function onThink(interval, lastExecution)

local texts =
{

        ["Trainers!"] 	= {{x=104, y=87, z=7},  55, TEXTCOLOR_DARKYELLOW},
        ["Welcome!"] 	= {{x=100, y=100, z=7}, 56, TEXTCOLOR_LIGHTBLUE}
		
}

        for text, param in pairs(texts) do
                doSendAnimatedText(param[1], text, param[3])
                doSendMagicEffect(param[1], param[2])
        end
        return TRUE
end