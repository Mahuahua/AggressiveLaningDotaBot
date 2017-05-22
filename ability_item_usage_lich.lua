function AbilityUsageThink()

  local npcBot = GetBot();

  local nova = npcBot:GetAbilityByName("lich_frost_nova");
  local armor = npcBot:GetAbilityByName("lich_frost_armor");
  local eat = npcBot:GetAbilityByName("lich_dark_ritual");
  local ult = npcBot:GetAbilityByName("lich_chain_frost");


  local towers = npcBot:GetNearbyTowers(1000, true);
  local barras = npcBot:GetNearbyBarracks(1000, true);
  if npcBot:IsChanneling() or npcBot:IsUsingAbility() then
    return;
  end
  if npcBot:GetActiveMode() == BOT_MODE_LANING then
    if npcBot:GetMana() == npcBot:GetMaxMana() or ((npcBot:GetMaxMana() - npcBot:GetMana()) / npcBot:GetManaRegen() < 60) or (npcBot:GetMana() / npcBot:GetMaxMana() > 0.45) then
      if nova:IsFullyCastable() then
        local targets = npcBot:GetNearbyHeroes( nova:GetCastRange() + 50, true, BOT_MODE_NONE);
        if #targets > 0 then
          local target = targets[RandomInt(1, #targets)];
          print("laning nova");
          return npcBot:Action_UseAbilityOnEntity(nova, target);
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
      if armor:IsFullyCastable() then
        return npcBot:ActionPush_UseAbilityOnEntity(armor, npcbot);
      end
    end
    local targets = npcBot:GetNearbyLaneCreeps( eat:GetCastRange(), false);
    if #targets > 0 and eat:IsFullyCastable() then
      local target = targets[RandomInt(1, #targets)]
      print("laning eat");
      return npcBot:ActionPush_UseAbilityOnEntity(eat, target);
    end
    local targets = npcBot:GetNearbyHeroes( armor:GetCastRange(), false, BOT_MODE_NONE);
    if #targets > 0 and armor:IsFullyCastable() then
      local target = targets[RandomInt(1, #targets)]
      print("laning armor");
      return npcBot:ActionPush_UseAbilityOnEntity(armor, target);
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_ATTACK then
    if nova:IsFullyCastable() then
      local targets = npcBot:GetNearbyHeroes( nova:GetCastRange() + 30, true, BOT_MODE_NONE);
      if #targets > 0 then
        local target = targets[RandomInt(1, #targets)]
        print("attacking nova");
        return npcBot:ActionPush_UseAbilityOnEntity(nova, target);
      end
    end
    if ult:IsFullyCastable() then
      local aoe = npcBot:FindAoELocation(true, true, npcBot:GetLocation(), 0, 1600, 0.0, 100000);
      if aoe.count >= 2 then
        print("attacking ult");
        return npcBot:ActionPush_UseAbility(ult);
      end
    end
    local targets = npcBot:GetNearbyLaneCreeps( eat:GetCastRange(), false);
    if #targets > 0 and eat:IsFullyCastable() then
      local target = targets[RandomInt(1, #targets)]
      print("attacking eat");
      return npcBot:ActionPush_UseAbilityOnEntity(eat, target);
    end
    local targets = npcBot:GetNearbyHeroes( armor:GetCastRange(), false, BOT_MODE_NONE);
    if #targets > 0 and armor:IsFullyCastable() then
      local target = targets[RandomInt(1, #targets)]
      print("attacking armor");
      return npcBot:ActionPush_UseAbilityOnEntity(armor, target);
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_TOP or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_MID or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_BOT then
    local targets = npcBot:GetNearbyHeroes( armor:GetCastRange(), false, BOT_MODE_NONE);
    if #targets > 0 and armor:IsFullyCastable() then
      local target = targets[RandomInt(1, #targets)]
      print("push armor");
      return npcBot:ActionPush_UseAbilityOnEntity(armor, target);
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_TOP or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_MID or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_BOT then
    local targets = npcBot:GetNearbyTowers( armor:GetCastRange(), false, BOT_MODE_NONE);
    if #targets > 0 and armor:IsFullyCastable() then
      local target = targets[RandomInt(1, #targets)]
      print("defendtower armor");
      return npcBot:ActionPush_UseAbilityOnEntity(armor, target);
    end
    local targets = npcBot:GetNearbyHeroes( armor:GetCastRange(), false, BOT_MODE_NONE);
    if #targets > 0 and armor:IsFullyCastable() then
      local target = targets[RandomInt(1, #targets)]
      print("defendtower armor");
      return npcBot:ActionPush_UseAbilityOnEntity(armor, target);
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY then
    local targets = npcBot:GetNearbyHeroes( armor:GetCastRange(), false, BOT_MODE_NONE);
    if #targets > 0 and armor:IsFullyCastable() then
      local target = targets[RandomInt(1, #targets)]
      print("defendally armor");
      return npcBot:ActionPush_UseAbilityOnEntity(armor, target);
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_ROSHAN then
    local targets = npcBot:GetNearbyHeroes( armor:GetCastRange(), false, BOT_MODE_NONE);
    if #targets > 0 and armor:IsFullyCastable() then
      local target = targets[RandomInt(1, #targets)]
      print("roshan armor");
      return npcBot:ActionPush_UseAbilityOnEntity(armor, target);
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_RETREAT then
    if armor:IsFullyCastable() then
      return npcBot:ActionPush_UseAbilityOnEntity(armor, npcbot);
    end
  end
end
