---Shelga, the Tri-Warlord
function c11000025.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(11000025,0))
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetCountLimit(1)
	e2:SetCondition(c11000025.skcon)
	e2:SetCost(c11000025.skcos)
	e2:SetTarget(c11000025.sktg)
	e2:SetOperation(c11000025.skop)
	c:RegisterEffect(e2)
end
function c11000025.skcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return (c:GetSequence()==6 or c:GetSequence()==7)
end
function c11000025.skfilter1(c,e,tp)
	return c:IsAbleToRemoveAsCost()
	and c:IsRace(RACE_PSYCHO)
	and c:IsType(TYPE_PENDULUM)
	and Duel.IsExistingMatchingCard(c11000025.skfilter2,tp,LOCATION_MZONE,0,1,nil,e,tp,c)
end
function c11000025.skfilter2(c,e,tp,tc1)
	return c:IsAbleToRemoveAsCost()
	and c:IsRace(RACE_PSYCHO)
	and c:IsType(TYPE_PENDULUM)
	and c~=tc1
	and Duel.IsExistingMatchingCard(c11000025.skfilter3,tp,LOCATION_MZONE,0,1,nil,e,tp,tc1,c)
end
function c11000025.skfilter3(c,e,tp,tc1,tc2)
	return c:IsAbleToRemoveAsCost()
	and c:IsRace(RACE_PSYCHO)
	and c:IsType(TYPE_PENDULUM)
	and c~=tc1
	and c~=tc2
	and Duel.IsExistingMatchingCard(c11000025.skfilter4,tp,LOCATION_MZONE,0,1,nil,e,tp,tc1,tc2,c)
end
function c11000025.skfilter4(c,e,tp,tc1,tc2,tc3)
	return c:IsFaceup()
	and c:IsCanBeEffectTarget(e)
	and c:IsType(TYPE_PENDULUM)
	and c~=tc1
	and c~=tc2
	and c~=tc3
end
function c11000025.skfilter5(c)
	return c:IsFaceup()
	and c:IsType(TYPE_PENDULUM)
end
function c11000025.skcos(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return Duel.IsExistingMatchingCard(c11000025.skfilter1,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	local g1=Duel.SelectMatchingCard(tp,c11000025.skfilter1,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	local tc1=g1:GetFirst()
	local g2=Duel.SelectMatchingCard(tp,c11000025.skfilter2,tp,LOCATION_MZONE,0,1,1,nil,e,tp,tc1)
	local tc2=g2:GetFirst()
	local g3=Duel.SelectMatchingCard(tp,c11000025.skfilter3,tp,LOCATION_MZONE,0,1,1,nil,e,tp,tc1,tc2)
	local tc3=g3:GetFirst()
	local g=Group.CreateGroup()
	g:AddCard(tc1)
	g:AddCard(tc2)
	g:AddCard(tc3)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end 
function c11000025.sktg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local tp=c:GetControler()
	if chk==0 then return true end
	Duel.SelectTarget(tp,c11000025.skfilter5,tp,LOCATION_MZONE,0,1,1,nil)
end 
function c11000025.skop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		--
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_MATCH_KILL)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
	end
end 
