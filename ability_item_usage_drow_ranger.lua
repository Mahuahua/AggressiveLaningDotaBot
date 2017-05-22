function AbilityUsageThink()

  local npcBot = GetBot();

  local arrow = npcBot:GetAbilityByName("drow_ranger_frost_arrows");
  local silence = npcBot:GetAbilityByName("drow_ranger_wave_of_silence");
  local aura = npcBot:GetAbilityByName("drow_ranger_trueshot");

  if npcBot:IsChanneling() or npcBot:IsUsingAbility() then
    return;
  end

  if npcBot:GetActiveMode() == BOT_MODE_LANING then
    if arrow:GetAutoCastState() == true then
      return arrow:ToggleAutoCast();
    end
    if npcBot:GetHealth() == npcBot:GetMaxHealth() or ((npcBot:GetMaxHealth() - npcBot:GetHealth()) / npcBot:GetHealthRegen() < 30) or (npcBot:GetHealth() / npcBot:GetMaxHealth() > 0.7) then
      local targets = npcBot:GetNearbyHeroes( npcBot:GetAttackRange() + 10, true, BOT_MODE_NONE);
      if #targets > 0 and GameTime() - npcBot:GetLastAttackTime() > npcBot:GetSecondsPerAttack() then
        local target = targets[RandomInt(1, #targets)];
        print("laning arrow");
        if arrow:IsFullyCastable() then
          return npcBot:ActionPush_UseAbilityOnEntity(arrow, target);
        end
        return npcBot:ActionPush_AttackUnit(target, true);
      end
    end
    local targets = npcBot:GetNearbyHeroes( 300, true, BOT_MODE_NONE);
    if #targets > 0 and silence:IsFullyCastable() then
      local target = targets[RandomInt(1, #targets)]
      print("laning silence");
      return npcBot:ActionPush_UseAbilityOnEntity(silence, target);
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_ATTACK then
    if silence:IsFullyCastable() then
      local aoe = npcBot:FindAoELocation(true, true, npcBot:GetLocation(), silence:GetCastRange(), 425, 0.0, 100000);
      if aoe.count >= 1 then
        print("attacking silence");
        return npcBot:ActionPush_UseAbilityOnLocation(silence, aoe.targetloc);
      end
    end
    if arrow:IsFullyCastable() then
      if arrow:GetAutoCastState() ~= true then
        return arrow:ToggleAutoCast();
      end
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_TOP or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_MID or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_BOT then
    if aura:IsFullyCastable() then
      return npcBot:ActionPush_UseAbility(aura);
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_TOP or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_MID or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_BOT then
    if aura:IsFullyCastable() then
      return npcBot:ActionPush_UseAbility(aura);
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_DEFEND_ALLY then
    if silence:IsFullyCastable() then
      local aoe = npcBot:FindAoELocation(true, true, npcBot:GetLocation(), silence:GetCastRange(), 425, 0.0, 100000);
      if aoe.count >= 1 then
        return npcBot:ActionPush_UseAbilityOnLocation(silence, aoe.targetloc);
      end
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_ROSHAN then
    if aura:IsFullyCastable() then
      return npcBot:ActionPush_UseAbility(aura);
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_RETREAT then
    if silence:IsFullyCastable() then
      local aoe = npcBot:FindAoELocation(true, true, npcBot:GetLocation(), silence:GetCastRange(), 425, 0.0, 100000);
      if aoe.count >= 1 then
        return npcBot:ActionPush_UseAbilityOnLocation(silence, aoe.targetloc);
      end
    end
  end

  if npcBot:GetActiveMode() == BOT_MODE_RETREAT or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_TOP or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_MID or npcBot:GetActiveMode() == BOT_MODE_PUSH_TOWER_BOT or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_TOP or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_MID or npcBot:GetActiveMode() == BOT_MODE_DEFEND_TOWER_BOT or npcBot:GetActiveMode() == BOT_MODE_FARM  or npcBot:GetActiveMode() == BOT_MODE_NONE then
    if arrow:GetAutoCastState() == true then
      return arrow:ToggleAutoCast();
    end
  end
end
