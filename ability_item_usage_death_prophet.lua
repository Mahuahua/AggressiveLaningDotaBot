function AbilityUsageThink()

  local npcBot = GetBot();

  local swarm = npcBot:GetAbilityByName("death_prophet_carrion_swarm");
  local silence = npcBot:GetAbilityByName("death_prophet_silence");
  local siphon = npcBot:GetAbilityByName("death_prophet_spirit_siphon");
  local ult = npcBot:GetAbilityByName("death_prophet_exorcism");


  local towers = npcBot:GetNearbyTowers(1000, true);
  local barras = npcBot:GetNearbyBarracks(1000, true);
  if npcBot:IsChanneling() or npcBot:IsUsingAbility() then
    return;
  end

  if npcBot:GetActiveMode() == BOT_MODE_LANING then
    if npcBot:GetMana() == npcBot:GetMaxMana() or ((npcBot:GetMaxMana() - npcBot:GetMana()) / npcBot:GetManaRegen() < 60) or (npcBot:GetMana() / npcBot:GetMaxMana() > 0.45) then
      if swarm:IsFullyCastable() then
        local targets = npcBot:GetNearbyHeroes( swarm:GetCastRange() + 130, true, BOT_MODE_NONE);
        if #targets > 0 then
          local target = targets[RandomInt(1, #targets)];
          print("laning swarm");
          return npcBot:Action_UseAbilityOnEntity(swarm, target);
        end
      end
    end

    if npcBot:GetHealth() == npcBot:GetMaxHealth() or ((npcBot:GetMaxHealth() - npcBot:GetHealth()) / npcBot:GetHealthRegen() < 30) or (npcBot:GetHealth() / npcBot:GetMaxHealth() > 0.7) then
      local targets = npcBot:GetNearbyHeroes( npcBot:GetAttackRange() + 10, true, BOT_MODE_NONE);
      if #targets > 0 and npcBot:GetLastAttackTime() > npcBot:GetSecondsPerAttack() then
        local target = targets[RandomInt(1, #targets)];
        print("laning attack");
        return npcBot:ActionPush_AttackUnit(target, true);
      end
    end

    local targets = npcBot:GetNearbyHeroes( 400, true, BOT_MODE_NONE);
    if #targets > 0 and siphon:IsFullyCastable() then
      local target = targets[RandomInt(1, #targets)]
      print("laning siphon");
      return npcBot:ActionPush_UseAbilityOnEntity(siphon, target);
    end
    return;
  end

  if npcBot:GetActiveMode() == BOT_MODE_ATTACK then
    if swarm:IsFullyCastable() then
      local targets = npcBot:GetNearbyHeroes( swarm:GetCastRange() + 100, true, BOT_MODE_NONE);
      if #targets > 3 then
        local target = targets[RandomInt(1, #targets)]
        print("attacking swarm");
        return npcBot:ActionPush_UseAbilityOnEntity(swarm, target);
      end
    end
    if siphon:IsFullyCastable() then
      local targets = npcBot:GetNearbyHeroes( siphon:GetCastRange(), true, BOT_MODE_NONE);
      if #targets > 0 then
        local target = targets[RandomInt(1, #targets)]
        print("attacking siphon");
        return npcBot:ActionPush_UseAbilityOnEntity(siphon, target);
      end
    end
    if silence:IsFullyCastable() then
      local aoe = npcBot:FindAoELocation(true, true, npcBot:GetLocation(), silence:GetCastRange(), 425, 0.0, 100000);
      if aoe.count >= 3 then
        print("attacking silence");
        return npcBot:ActionPush_UseAbilityOnLocation(silence, aoe.targetloc);
      end
    end
    if ult:IsFullyCastable() then
      local aoe = npcBot:FindAoELocation(true, true, npcBot:GetLocation(), 0, 1600, 0.0, 100000);
      if aoe.count >= 3 then
        print("attacking ult");
        return npcBot:ActionPush_UseAbility(ult);
      end
    end
    if swarm:IsFullyCastable() then
      local targets = npcBot:GetNearbyHeroes( swarm:GetCastRange() + 130, true, BOT_MODE_NONE);
      if #targets > 0 then
        local target = targets[RandomInt(1, #targets)]
        print("attacking swarm2");
        return npcBot:ActionPush_UseAbilityOnEntity(swarm, target);
      end
    end
    if silence:IsFullyCastable() then
      local aoe = npcBot:FindAoELocation(true, true, npcBot:GetLocation(), silence:GetCastRange(), 425, 0.0, 100000);
      if aoe.count > 0 then
        print("attacking silence2");
        return npcBot:ActionPush_UseAbilityOnLocation(silence, aoe.targetloc);
      end
    end
    return;
  end

  if npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_TOP or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_MID or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_BOT then
    if ult:IsFullyCastable() and (#towers > 0 or  #barras > 0) then
      return npcBot:ActionPush_UseAbility(ult);
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_TOP or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_MID or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_BOT then
    if ult:IsFullyCastable() and (#towers > 0 or  #barras > 0) then
      return npcBot:ActionPush_UseAbility(ult);
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY then
    if silence:IsFullyCastable() then
      local aoe = npcBot:FindAoELocation(true, true, npcBot:GetLocation(), silence:GetCastRange(), 425, 0.0, 100000);
      if aoe.count >= 3 then
        return npcBot:ActionPush_UseAbilityOnLocation(silence, aoe.targetloc);
      end
    end
    if siphon:IsFullyCastable() and (RandomInt(1, 5) >= 4) then
      local targets = npcBot:GetNearbyHeroes( siphon:GetCastRange() - 50, true, BOT_MODE_NONE);
      if #targets > 0 then
        local target = targets[RandomInt(1, #targets)]
        return npcBot:ActionPush_UseAbilityOnEntity(siphon, target);
      end
    end
    if swarm:IsFullyCastable() then
      local targets = npcBot:GetNearbyHeroes( swarm:GetCastRange() - 100, true, BOT_MODE_NONE);
      if #targets > 3 then
        local target = targets[RandomInt(1, #targets)]
        return npcBot:ActionPush_UseAbilityOnEntity(siphon, target);
      end
    end
    if silence:IsFullyCastable() then
      local aoe = npcBot:FindAoELocation(true, true, npcBot:GetLocation(), silence:GetCastRange(), 425, 0.0, 100000);
        return npcBot:ActionPush_UseAbilityOnLocation(silence, aoe.targetloc);
    end
    if swarm:IsFullyCastable() then
      local targets = npcBot:GetNearbyHeroes( swarm:GetCastRange() - 100, true, BOT_MODE_NONE);
      if #targets > 0 then
        local target = targets[RandomInt(1, #targets)]
        return npcBot:ActionPush_UseAbilityOnEntity(siphon, target);
      end
    end
    return;
  end

  if npcBot:GetActiveMode() == BOT_MODE_ROSHAN then
    if ult:IsFullyCastable() then
      return npcBot:ActionPush_UseAbility(ult);
    end
  end
  
  if npcBot:GetActiveMode() == BOT_MODE_RETREAT then
    if silence:IsFullyCastable() then
      local aoe = npcBot:FindAoELocation(true, true, npcBot:GetLocation(), silence:GetCastRange(), 425, 0.0, 100000);
      if aoe.count >= 3 then
        return npcBot:ActionPush_UseAbilityOnLocation(silence, aoe.targetloc);
      end
    end
  end
end
