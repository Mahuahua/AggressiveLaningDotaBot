function MinionThink( hMinionUnit )
--illusions from unexpected sources (not to be overwrited) goes to random places to waste other team's skills
  if hMinionUnit:IsIllusion() and hMinionUnit:NumQueuedActions() == 0 then
     local enemyTeam = TEAM_RADIANT
     if GetTeam() == TEAM_RADIANT then
       enemyTeam = TEAM_DIRE
     end
     local randomNum = RandomInt(1, 3)
     if (randomNum == 3) then
         return hMinionUnit:ActionQueue_AttackMove(GetLaneFrontLocation(enemyTeam, LANE_TOP, 0));
     end
     if (randomNum == 2) then
         return hMinionUnit:ActionQueue_AttackMove(GetLaneFrontLocation(enemyTeam, LANE_BOT, 0));
     end
     if (randomNum == 1) then
         return hMinionUnit:ActionQueue_AttackMove(GetLaneFrontLocation(enemyTeam, LANE_MID, 0));
     end

  end
end
