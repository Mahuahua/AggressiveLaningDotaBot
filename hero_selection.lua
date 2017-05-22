
allBotHeroes = {
        'npc_dota_hero_axe',
        'npc_dota_hero_bane',
        'npc_dota_hero_bloodseeker',
        'npc_dota_hero_bounty_hunter',
        'npc_dota_hero_bristleback',
        'npc_dota_hero_chaos_knight',
        'npc_dota_hero_crystal_maiden',
        'npc_dota_hero_dazzle',
        'npc_dota_hero_death_prophet',
        'npc_dota_hero_dragon_knight',
        'npc_dota_hero_drow_ranger',
        'npc_dota_hero_earthshaker',
        'npc_dota_hero_jakiro',
        'npc_dota_hero_juggernaut',
        'npc_dota_hero_kunkka',
        'npc_dota_hero_lich',
        'npc_dota_hero_lina',
        'npc_dota_hero_lion',
        'npc_dota_hero_luna',
        'npc_dota_hero_necrolyte',
        'npc_dota_hero_nevermore',
        'npc_dota_hero_omniknight',
        'npc_dota_hero_oracle',
        'npc_dota_hero_phantom_assassin',
        'npc_dota_hero_pudge',
        'npc_dota_hero_razor',
        'npc_dota_hero_sand_king',
        'npc_dota_hero_skeleton_king',
        'npc_dota_hero_skywrath_mage',
        'npc_dota_hero_sniper',
        'npc_dota_hero_sven',
        'npc_dota_hero_tidehunter',
        'npc_dota_hero_tiny',
        'npc_dota_hero_vengefulspirit',
        'npc_dota_hero_viper',
        'npc_dota_hero_warlock',
        'npc_dota_hero_windrunner',
        'npc_dota_hero_witch_doctor',
        'npc_dota_hero_zuus'
};
----------------------------------------------------------------------------------------------------

function Think()
  local IDs = GetTeamPlayers(GetTeam());
  for i,id in pairs(IDs) do
    if IsPlayerBot(id) then
      PickBot(id);
    end
  end

end

function GetPicks()
    local picked = {};
    local pickedSlots = {};
    for i=0, 9 do
        local hName = GetSelectedHeroName(i);
        if (hName ~= nil and hName ~= "") then
            picked[i] = hName;
        end
    end
    return picked;
end

function PickBot(slot)
  --testing
  if slot == 4 then
    SelectHero(4, 'npc_dota_hero_death_prophet');
    return;
  end
  if slot == 3 then
    SelectHero(3, 'npc_dota_hero_viper');
    return;
  end
  if slot == 2 then
    SelectHero(2, 'npc_dota_hero_dazzle');
    return;
  end
  if slot == 5 then
    SelectHero(5, 'npc_dota_hero_drow_ranger');
    return;
  end
  if slot == 6 then
    SelectHero(6, 'npc_dota_hero_lich');
    return;
  end
  local hero = GetRandomHero();
  --print("picking hero ", hero, " for slot ", slot);
  SelectHero(slot, hero);
end


function GetRandomHero()
    local hero;
    local picks = GetPicks();
    local pickedHeroes = {};
    for slot, hero in pairs(picks) do
      pickedHeroes[hero] = true;
    end

    if (hero == nil) then
        hero = allBotHeroes[RandomInt(1, #allBotHeroes)];
    end

    while ( pickedHeroes[hero] == true ) do
        --print("repicking because " .. hero .. " was taken.")
        hero = allBotHeroes[RandomInt(1, #allBotHeroes)];
    end
    return hero;
end

function UpdateLaneAssignments()
  if ( GetTeam() == TEAM_RADIANT ) then
    return {
      [1] = LANE_TOP,
      [2] = LANE_TOP,
      [3] = LANE_MID,
      [4] = LANE_BOT,
      [5] = LANE_BOT,
    };
  elseif ( GetTeam() == TEAM_DIRE ) then
    return {
      [1] = LANE_TOP,
      [2] = LANE_TOP,
      [3] = LANE_MID,
      [4] = LANE_BOT,
      [5] = LANE_BOT,
    };
  end
end

----------------------------------------------------------------------------------------------------
