function AbilityUsageThink()

  local npcBot = GetBot();

  local poison = npcBot:GetAbilityByName("viper_poison_attack");
  local ult = npcBot:GetAbilityByName("viper_viper_strike");

  if npcBot:IsChanneling() or npcBot:IsUsingAbility() then
    return;
  end

  if npcBot:GetActiveMode() == BOT_MODE_LANING then
    if poison:GetAutoCastState() == true then
      return poison:ToggleAutoCast();
    end
    if npcBot:GetHealth() == npcBot:GetMaxHealth() or ((npcBot:GetMaxHealth() - npcBot:GetHealth()) / npcBot:GetHealthRegen() < 30) or (npcBot:GetHealth() / npcBot:GetMaxHealth() > 0.7) then
      local targets = npcBot:GetNearbyHeroes( npcBot:GetAttackRange() + 10, true, BOT_MODE_NONE);
      if #targets > 0 and npcBot:GetLastAttackTime() > npcBot:GetSecondsPerAttack() then
        local target = targets[RandomInt(1, #targets)];
        print("laning poison");
        if poison:IsFullyCastable() then
          return npcBot:ActionPush_UseAbilityOnEntity(poison, target);
        end
        return npcBot:ActionPush_AttackUnit(target, true);
      end
    end
    local targets = npcBot:GetNearbyHeroes( ult:GetCastRange() - 200, true, BOT_MODE_NONE);
    if #targets > 0 and ult:IsFullyCastable() then
      local target = targets[RandomInt(1, #targets)]
      print("laning ult");
      return npcBot:ActionPush_UseAbilityOnEntity(ult, target);
    end
    return;
  end

  if npcBot:GetActiveMode() == BOT_MODE_ATTACK then
    local targets = npcBot:GetNearbyHeroes( ult:GetCastRange() , true, BOT_MODE_NONE);
    if #targets > 0 and ult:IsFullyCastable() then
      local target = targets[RandomInt(1, #targets)]
      print("attack ult");
      return npcBot:ActionPush_UseAbilityOnEntity(ult, target);
    end
    local targets = npcBot:GetNearbyHeroes( npcBot:GetAttackRange() + 10, true, BOT_MODE_NONE);
    if #targets > 0 and poison:IsFullyCastable() then
      if poison:GetAutoCastState() ~= true then
        return poison:ToggleAutoCast();
      end
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY then
    local targets = npcBot:GetNearbyHeroes( ult:GetCastRange() , true, BOT_MODE_NONE);
    if #targets > 0 and ult:IsFullyCastable() then
      local target = targets[RandomInt(1, #targets)]
      print("defense ult");
      return npcBot:ActionPush_UseAbilityOnEntity(ult, target);
    end
    local targets = npcBot:GetNearbyHeroes( npcBot:GetAttackRange() - 100, true, BOT_MODE_NONE);
    if #targets > 0 and poison:IsFullyCastable() then
      if poison:GetAutoCastState() ~= true then
        return poison:ToggleAutoCast();
      end
    end
  end


  if npcBot:GetActiveMode() == BOT_MODE_RETREAT or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_TOP or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_MID or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_BOT or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_TOP or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_MID or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_BOT or npcBot:GetActiveMode() == BOT_MODE_FARM  or npcBot:GetActiveMode() == BOT_MODE_NONE then
    if poison:GetAutoCastState() == true then
      return poison:ToggleAutoCast();
    end
  end
end
