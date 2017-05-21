function GetDesire()
    local npcBot = GetBot();
    local score = 0.0;
    if (npcBot:GetMana() / npcBot:GetMaxMana() < 0.45) then
      score = score + 0.15
    end
    if (npcBot:GetMana() / npcBot:GetMaxMana() < 0.25) then
      score = score + 0.25
    end
    if (npcBot:GetMana() / npcBot:GetMaxMana() < 0.1) then
      score = score + 0.4
    end
    if (npcBot:GetHealth() / npcBot:GetMaxHealth() < 0.7) then
       score = score + 0.2
    end
    if (npcBot:GetHealth() / npcBot:GetMaxHealth() < 0.45) then
       score = score + 0.5
    end
    if (npcBot:GetHealth() / npcBot:GetMaxHealth() < 0.3) then
       score = score + 1
    end

    if score > 1 then
      return 1
    end
    return score
end
