--黒衣之詔刀師
--Noritoshi in Darkest Rainment
function c11000028.initial_effect(c)
	--link summon
	aux.AddLinkProcedure(c,c11000028.matfilter,3)
	c:EnableReviveLimit()
	--specialsummon link only
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(c11000028.splimit)
	c:RegisterEffect(e1)
	--match kill
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_MATCH_KILL)
	e1:SetCondition(c11000028.con)
	c:RegisterEffect(e1)
end
function c11000028.matfilter(c)
	return c:IsRace(RACE_SPELLCASTER) and c:IsLinkType(TYPE_EFFECT)
end
function c11000028.splimit(e,se,sp,st)
	return bit.band(st,SUMMON_TYPE_LINK)==SUMMON_TYPE_LINK
end
function c11000028.con(e)
	return e:GetHandler():IsExtraLinked()
end