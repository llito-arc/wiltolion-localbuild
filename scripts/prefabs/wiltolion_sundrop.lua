local assets = {
    Asset("ANIM", "anim/wiltolion_sundrop.zip"),
    Asset("IMAGE", "images/inventoryimages/wiltolion_sundrop.tex"),
    Asset("ATLAS", "images/inventoryimages/wiltolion_sundrop.xml"),
}

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
    inst:AddTag("nosteal") -- Evita que monos o Krampus lo roben y crasheen

    -- LÓGICA DE CLIENTE: Solo controlamos la luz y visibilidad en el inventario
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
    inst.components.edible.hungervalue = 1
    inst.components.edible.sanityvalue = 0

    inst.components.edible:SetOnEatenFn(function(inst, eater)
        if eater ~= nil and eater:IsValid() then
            local fx = SpawnPrefab("halloween_firepuff_1")
            if fx ~= nil then
                -- Obtenemos la posición de quien se lo come (Wiltolion)
                local x, y, z = eater.Transform:GetWorldPosition()
                -- Subimos un poco la "Y" para que la chispa salga cerca de su boca/cabeza
                fx.Transform:SetPosition(x, y + 1, z)
                -- Reducimos su escala a la mitad para que sea "pequeñito"
                fx.Transform:SetScale(0.5, 0.5, 0.5)
            end
        end
    end)

    inst:AddComponent("inventoryitem")
    inst.components.inventoryitem.imagename = "wiltolion_sundrop"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/wiltolion_sundrop.xml"
    
    -- ==========================================
    -- LA MAGIA DE WORTOX:
    -- ==========================================
    --inst.components.inventoryitem.canonlygoinpocketorpocketcontainers = true
    
    inst:AddComponent("stackable")
    inst.components.stackable.maxsize = TUNING.STACK_SIZE_SMALLITEM

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

    -- DESAPARICIÓN
    local function StopDespawnTimer(inst)
        if inst._despawn_task ~= nil then
            inst._despawn_task:Cancel()
            inst._despawn_task = nil
        end
    end

    local function StartDespawnTimer(inst)
        StopDespawnTimer(inst)
        inst._despawn_task = inst:DoTaskInTime(15, function(inst)
            -- NUEVA LÍNEA: Si el objeto está en un inventario, no lo borres.
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
    inst:ListenForEvent("ondropped", StartDespawnTimer)
    -- ==========================================
    -- FRASES AL QUEMARSE / SOLTAR EL SUNDROP
    -- ==========================================
    local drop_quotes = {
        -- Personajes Base
        wilson = "Yowch! That completely defies the laws of thermodynamics!",
        willow = "Aw, it's so warm! Why won't it stay in my hands?", -- No le duele, pero no puede retenerlo
        wolfgang = "Ouch! Is like holding tiny angry sun!",
        wendy = "It burns... much like the fleeting illusion of hope.",
        wx78 = "ERROR: UNCONTAINABLE HEAT SOURCE DETECTED.",
        wickerbottom = "Goodness! The solar radiation is quite severe.",
        woodie = "Ouch! That's a spicy little ember, eh?",
        wes = "", -- Wes es mudo, se salta el diálogo
        maxwell = "Gah! Insolent little spark!",
        wigfrid = "Odin's beard! It burns with the fury of Muspelheim!",
        webber = "Owie! It burned our fuzzy hands!",
        -- Personajes DLC / Expansiones
        winona = "Yeesh! That's a workplace hazard if I ever saw one.",
        warly = "Mon dieu! It's hotter than a boiling skillet!",
        wortox = "Hyuyu! Too spicy for my pockets!",
        wormwood = "Aah! Hot! Hot! Hurts!", -- A Wormwood (planta) le aterra el fuego/calor
        wurt = "Glurgh! It burns the scales, florp!",
        walter = "Yikes! I need to review my first-aid badge for burns!",
        wanda = "Ouch! I don't have the time to deal with blistered hands!",
        wone = "..."
    }
    local default_drop_quote = "Ouch! It's burning hot!"

    -- ==========================================
    -- ANTI-ROBO (Para otros jugadores)
    -- ==========================================
    inst:ListenForEvent("onputininventory", function(inst, owner)
        StopDespawnTimer(inst)

        -- Gracias a la magia de Wortox, el "owner" SIEMPRE será el jugador, 
        -- porque el motor ya prohibió que entrara en cofres o Chester.
        if owner ~= nil and not owner:HasTag("wiltolion") then
            inst:DoTaskInTime(0, function()
                if owner.components.inventory ~= nil then
                    owner.components.inventory:DropItem(inst, true, true)
                end
                if owner.components.talker ~= nil then
                    -- Busca el nombre del personaje (owner.prefab) en la tabla
                    -- Si no está en la tabla, usa la frase por defecto
                    local quote = drop_quotes[owner.prefab] or default_drop_quote
                    
                    -- Solo habla si la frase NO está vacía (esto protege a Wes)
                    if quote ~= "" then
                        owner.components.talker:Say(quote)
                    end
                end
            end)
        end
    end)
    -- Cuando el motor termina de cargar el objeto desde el archivo de guardado
    inst.OnLoad = function(inst)
        -- Si al cargar, el motor lo asignó a un dueño (está en un inventario)
        if inst.components.inventoryitem ~= nil and inst.components.inventoryitem.owner ~= nil then
            StopDespawnTimer(inst)
        end
    end

    return inst
end

return Prefab("wiltolion_sundrop", fn, assets)