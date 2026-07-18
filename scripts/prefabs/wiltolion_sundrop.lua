local assets = {
    Asset("ANIM", "anim/wiltolion_sundrop.zip"),
    Asset("IMAGE", "images/inventoryimages/wiltolion_sundrop.tex"),
    Asset("ATLAS", "images/inventoryimages/wiltolion_sundrop.xml"),
}

local function OnDeploy(inst, pt, deployer)
    -- Strict validation: Check if deployer has enough hunger to pay the cost
    if deployer ~= nil and deployer.components.hunger ~= nil then
        if deployer.components.hunger.current < 10 then
            -- Provide feedback to the player and cancel the deployment
            if deployer.components.talker ~= nil then
                deployer.components.talker:Say("I'm hungry!")
            end
            return
        end
        
        -- Safely deduct 10 hunger
        deployer.components.hunger:DoDelta(-10)
    end

    local flower = SpawnPrefab("wiltolion_flower")
    if flower ~= nil then
        flower.Transform:SetPosition(pt:Get())
        
        -- Consume the item
        inst.components.stackable:Get():Remove()
        
        if deployer ~= nil and deployer.SoundEmitter ~= nil then
            deployer.SoundEmitter:PlaySound("dontstarve/wilson/plant_seeds")
        end
    end
end

local function fn()
    local inst = CreateEntity()

    inst.entity:AddTransform()
    inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)

    inst.AnimState:SetBank("wiltolion_sundrop")
    inst.AnimState:SetBuild("wiltolion_sundrop")
    inst.AnimState:PlayAnimation("idle")
    inst.AnimState:SetBloomEffectHandle("shaders/anim.ksh")

    inst.entity:AddLight()
    inst.Light:SetFalloff(0.7)
    inst.Light:SetIntensity(0.5)
    inst.Light:SetRadius(0.5)
    inst.Light:SetColour(255/255, 200/255, 100/255)
    inst.Light:Enable(true)

    inst:AddTag("wiltolion_sundrop")
    inst:AddTag("nosteal") -- Prevents monkeys or Krampus from stealing it and causing crashes
    inst:AddTag("irreplaceable") -- Nace siendo ignorado por la IA

    -- CLIENT LOGIC: We only control the light and visibility in inventory
    inst:DoPeriodicTask(0.1, function(inst)
        if ThePlayer ~= nil and ThePlayer:HasTag("wiltolion") then
            local is_held = inst.replica.inventoryitem ~= nil and inst.replica.inventoryitem:IsHeld()
            if is_held then
                inst:Hide()
                inst.Light:Enable(false)
            else
                inst:Show()
                inst.Light:Enable(true)
            end
        end
    end)

    inst.entity:SetPristine()

    if not TheWorld.ismastersim then
        return inst
    end

    inst:AddComponent("inspectable")

    inst:AddComponent("edible")
    inst.components.edible.foodtype = FOODTYPE.GENERIC
    inst.components.edible.healthvalue = 2
    inst.components.edible.hungervalue = 2
    inst.components.edible.sanityvalue = 0

    -- ==========================================
    -- DEPLOYABLE SETUP (PLANTING FLOWERS)
    -- ==========================================
    inst:AddComponent("deployable")
    inst.components.deployable.ondeploy = OnDeploy
    inst.components.deployable:SetDeployMode(DEPLOYMODE.PLANT)
    inst.components.deployable:SetDeploySpacing(DEPLOYSPACING.LESS)

    inst.components.edible:SetOnEatenFn(function(inst, eater)
        if eater ~= nil and eater:IsValid() then
            local fx = SpawnPrefab("halloween_firepuff_1")
            if fx ~= nil then
                -- Get the position of who eats it (Wiltolion)
                local x, y, z = eater.Transform:GetWorldPosition()
                -- Raise the "Y" a bit so the spark comes out near their mouth/head
                fx.Transform:SetPosition(x, y + 1, z)
                -- Reduce its scale by half to make it "tiny"
                fx.Transform:SetScale(0.5, 0.5, 0.5)
            end
        end
    end)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "wiltolion_sundrop"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/wiltolion_sundrop.xml"
    
    inst:AddComponent("stackable")

    -- ==========================================
    -- REPLICA WORKAROUND (DO NOT DELETE)
    -- Avoids LUA ERROR from client with stacks of 200/30
    -- ==========================================
    local _replica_SetMaxSize = inst.replica.stackable.SetMaxSize
    inst.replica.stackable.SetMaxSize = function(self, maxsize)
        if maxsize == 200 or maxsize == 50 then
            self._ignoremaxsize:set(true)
        else
            _replica_SetMaxSize(self, maxsize)
        end
    end

    -- Default max stack size is 200
    inst.components.stackable.maxsize = 200

    MakeHauntableLaunch(inst)

    inst._fall_task = inst:DoPeriodicTask(FRAMES, function(inst)
        local x, y, z = inst.Transform:GetWorldPosition()
        if y > 0.1 then
            inst.Physics:SetVel(0, -1.5, 0)
        else
            if inst._fall_task ~= nil then
                inst._fall_task:Cancel()
                inst._fall_task = nil
            end
        end
    end)

    -- DISAPPEARANCE
    local function StopDespawnTimer(inst)
        if inst._despawn_task ~= nil then
            inst._despawn_task:Cancel()
            inst._despawn_task = nil
        end
    end

    local function StartDespawnTimer(inst)
        StopDespawnTimer(inst)
        inst._despawn_task = inst:DoTaskInTime(15, function(inst)
            if inst.components.inventoryitem ~= nil and inst.components.inventoryitem:IsHeld() then
                return
            end

            local fx = SpawnPrefab("halloween_firepuff_1")
            if fx then
                local x, y, z = inst.Transform:GetWorldPosition()
                fx.Transform:SetPosition(x, y, z)
            end
            inst:Remove()
        end)
    end

    StartDespawnTimer(inst)
    inst:ListenForEvent("ondropped", function(i)
        StartDespawnTimer(i)
        -- Si toca el suelo, la IA vuelve a ignorarlo
        i:AddTag("irreplaceable")
    end)

    -- ==========================================
    -- PHRASES WHEN BURNING / DROPPING THE SUNDROP
    -- ==========================================
    local drop_quotes = {
        wilson = "Yowch! That completely defies the laws of thermodynamics!",
        willow = "Aw, it's so warm! Why won't it stay in my hands?", 
        wolfgang = "Ouch! Is like holding tiny angry sun!",
        wendy = "It burns... much like the fleeting illusion of hope.",
        wx78 = "ERROR: UNCONTAINABLE HEAT SOURCE DETECTED.",
        wickerbottom = "Goodness! The solar radiation is quite severe.",
        woodie = "Ouch! That's a spicy little ember, eh?",
        wes = "", 
        maxwell = "Gah! Insolent little spark!",
        wigfrid = "Odin's beard! It burns with the fury of Muspelheim!",
        webber = "Owie! It burned our fuzzy hands!",
        winona = "Yeesh! That's a workplace hazard if I ever saw one.",
        warly = "Mon dieu! It's hotter than a boiling skillet!",
        wortox = "Hyuyu! Too spicy for my pockets!",
        wormwood = "Aah! Hot! Hot! Hurts!", 
        wurt = "Glurgh! It burns the scales, florp!",
        walter = "Yikes! I need to review my first-aid badge for burns!",
        wanda = "Ouch! I don't have the time to deal with blistered hands!",
        wone = "..."
    }
    local default_drop_quote = "Ouch! It's burning hot!"

    -- ==========================================
    -- MASTER LOGIC: ANTI-THEFT AND CONTAINER CONTROL
    -- ==========================================
    inst:ListenForEvent("onputininventory", function(inst, owner)
        StopDespawnTimer(inst)
        inst:RemoveTag("irreplaceable")

        if owner ~= nil then
            -- 1. If it went into the PYLON
            if owner.prefab == "wiltolion_pylon" then
                inst.components.stackable.maxsize = 50
                
                local current_stack = inst.components.stackable:StackSize()
                if current_stack > 50 then
                    local excess_amount = current_stack - 50
                    local excess_item = inst.components.stackable:Get(excess_amount)
                    
                    if owner.components.container ~= nil then
                        owner.components.container:DropItem(excess_item)
                    end
                end

            -- 2. If it went directly into Wiltolion's inventory (pockets)
            elseif owner:HasTag("player") and owner:HasTag("wiltolion") then
                inst.components.stackable.maxsize = 200

            -- 3. If it went into Backpacks, Chests, Chester, or any other player
            else
                inst:DoTaskInTime(0, function()
                    -- We eject it regardless of whether it's an inventory or container
                    if owner.components.inventory ~= nil then
                        owner.components.inventory:DropItem(inst, true, true)
                    elseif owner.components.container ~= nil then
                        owner.components.container:DropItem(inst)
                    end
                    
                    -- If whoever tried to grab it was a fake player or someone else, we make them talk
                    if owner:HasTag("player") and owner.components.talker ~= nil then
                        local quote = drop_quotes[owner.prefab] or default_drop_quote
                        if quote ~= "" then
                            owner.components.talker:Say(quote)
                        end
                    end
                end)
            end
        end
    end)

    inst.OnLoad = function(inst)
        if inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner ~= nil then
            StopDespawnTimer(inst)
        end
    end

    return inst
end

-- ==========================================
-- GHOST PLACER FOR GEOMETRIC PLACEMENT
-- ==========================================
-- MakePlacer arguments: prefab_name, bank, build, default_animation
return Prefab("wiltolion_sundrop", fn, assets),
       MakePlacer("wiltolion_sundrop_placer", "wiltolion_flower", "wiltolion_flower", "f1")