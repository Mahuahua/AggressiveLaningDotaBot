function AbilityUsageThink()

  local npcBot = GetBot();

  local poison = npcBot:GetAbilityByName("dazzle_poison_touch");
  local grave = npcBot:GetAbilityByName("dazzle_shallow_grave");
  local heal = npcBot:GetAbilityByName("dazzle_shadow_wave");
  local ult = npcBot:GetAbilityByName("dazzle_weave");


  local towers = npcBot:GetNearbyTowers(1000, true);
  local barras = npcBot:GetNearbyBarracks(1000, true);
  if npcBot:IsChanneling() or npcBot:IsUsingAbility() then
    return;
  end


  local targets = npcBot:GetNearbyHeroes( grave:GetCastRange(), false, BOT_MODE_NONE);
  if grave:IsFullyCastable() and #targets > 0 then
    for i,target in pairs(targets) do
      if grave:IsFullyCastable() and (target:GetHealth() / target:GetMaxHealth() < 0.2) then
        return npcBot:ActionPush_UseAbilityOnEntity(grave, target);
      end
    end
  end
  local targets = npcBot:GetNearbyHeroes( heal:GetCastRange(), false, BOT_MODE_NONE);

  if heal:IsFullyCastable() and #targets > 0 then
    for i,target in pairs(targets) do
      if grave:IsFullyCastable() and (target:GetHealth() / target:GetMaxHealth() < 0.5) then
        return npcBot:ActionPush_UseAbilityOnEntity(heal, target);
      end
    end
  end


  if npcBot:GetActiveMode() == BOT_MODE_LANING then
    if npcBot:GetMana() == npcBot:GetMaxMana() or ((npcBot:GetMaxMana() - npcBot:GetMana()) / npcBot:GetManaRegen() < 60) or (npcBot:GetMana() / npcBot:GetMaxMana() > 0.45) then
      if poison:IsFullyCastable() then
        local targets = npcBot:GetNearbyHeroes( poison:GetCastRange() + 50, true, BOT_MODE_NONE);
        if #targets > 0 then
          local target = targets[RandomInt(1, #targets)];
          print("laning poison");
          return npcBot:Action_UseAbilityOnEntity(poison, target);
        end
      end
    end
    if npcBot:GetHealth() == npcBot:GetMaxHealth() or ((npcBot:GetMaxHealth() - npcBot:GetHealth()) / npcBot:GetHealthRegen() < 30) or (npcBot:GetHealth() / npcBot:GetMaxHealth() > 0.7) then
      local targets = npcBot:GetNearbyHeroes( npcBot:GetAttackRange() + 10, true, BOT_MODE_NONE);
      if #targets > 0 and GameTime() - npcBot:GetLastAttackTime() > npcBot:GetSecondsPerAttack() then
        local target = targets[RandomInt(1, #targets)];
        print("laning attack");
        return npcBot:ActionPush_AttackUnit(target, true);
      end
    else
      if grave:IsFullyCastable() and (npcBot:GetHealth() / npcBot:GetMaxHealth() < 0.6) then
        return npcBot:ActionPush_UseAbilityOnEntity(heal, npcbot);
      end
      if grave:IsFullyCastable() and (npcBot:GetHealth() / npcBot:GetMaxHealth() < 0.3) then
        return npcBot:ActionPush_UseAbilityOnEntity(grave, npcbot);
      end
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_ATTACK then
    if poison:IsFullyCastable() then
      local targets = npcBot:GetNearbyHeroes( poison:GetCastRange() + 30, true, BOT_MODE_NONE);
      if #targets > 0 then
        local target = targets[RandomInt(1, #targets)]
        print("attacking poison");
        return npcBot:ActionPush_UseAbilityOnEntity(poison, target);
      end
    end
    if ult:IsFullyCastable() then
      local aoe = npcBot:FindAoELocation(true, true, npcBot:GetLocation(), 0, 1600, 0.0, 100000);
      if aoe.count >= 2 then
        print("attacking ult");
        return npcBot:ActionPush_UseAbilityOnLocation(ult, aoe.targetloc);
      end
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_TOP or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_MID or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_BOT then
    if ult:IsFullyCastable() then
      local aoe = npcBot:FindAoELocation(false, true, npcBot:GetLocation(), 0, 1600, 0.0, 100000);
      if aoe.count >= 2 then
        print("push ult");
        return npcBot:ActionPush_UseAbilityOnLocation(ult, aoe.targetloc);
      end
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_TOP or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_MID or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_BOT then
    if ult:IsFullyCastable() then
      local aoe = npcBot:FindAoELocation(false, true, npcBot:GetLocation(), 0, 1600, 0.0, 100000);
      if aoe.count >= 2 then
        print("deftower ult");
        return npcBot:ActionPush_UseAbilityOnLocation(ult, aoe.targetloc);
      end
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_ROSHAN then
    if ult:IsFullyCastable() then
      local aoe = npcBot:FindAoELocation(false, true, npcBot:GetLocation(), 0, 1600, 0.0, 100000);
      if aoe.count >= 2 then
        print("deftower ult");
        return npcBot:ActionPush_UseAbilityOnLocation(ult, aoe.targetloc);
      end
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_RETREAT then
      if heal:IsFullyCastable() then
        return npcBot:ActionPush_UseAbilityOnEntity(heal, npcbot);
      end
      if grave:IsFullyCastable() then
        return npcBot:ActionPush_UseAbilityOnEntity(grave, npcbot);
      end
  end
end
