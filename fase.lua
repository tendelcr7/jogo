-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here




local composer = require( "composer" )
local scene = composer.newScene()



local pontos = 0;


local fundo = display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth*2,display.contentHeight*2)
fundo:setFillColor( 0, 0, 0 )

local madeira = display.newImageRect("sprites/madeira.jpg",(4999/8)+500,(4999/8))
madeira.x = display.contentCenterX
madeira.y = display.contentCenterY
madeira.vida = 999


local SplashSound = audio.loadSound( "sfx/SPLASH_Sound.wav" )
local FundoSound = audio.loadSound( "sfx/fundo_fase.wav" )
local FundoChannel = audio.play( FundoSound )


local pontuacao = display.newText( "Pontos: 0", display.contentWidth-50, -20, native.systemFont, 17 )
pontuacao:setFillColor( 1, 1,1, 1 )
 

local gosma = display.newImageRect("sprites/gosma.png",(1194/20),(1471/20))
gosma.x = display.contentCenterX
gosma.y = display.contentCenterY



local sequences_runningAnt = {
    
    {
        name = "normalRun",
        start = 1,
        count = 4,
        time = 300,
        loopCount = 0,
        loopDirection = "forward"
    }
}

local sheetOptions =
{
    width = 65,
    height = 90,
    numFrames = 2
}

local sheet_runningAnt = graphics.newImageSheet( "sprites/formiga_animada_n.png", sheetOptions )
local formiga_a = display.newSprite( sheet_runningAnt, sequences_runningAnt )



formiga_a.x = display.contentCenterX
formiga_a.y = display.contentCenterY
formiga_a.vida = 1

formiga_a:play()



local formiga_b = display.newSprite( sheet_runningAnt, sequences_runningAnt )
formiga_b.x = display.contentCenterX/3
formiga_b.y = display.contentCenterY
formiga_b.vida = 1
formiga_b:play()

local formiga_c = display.newSprite( sheet_runningAnt, sequences_runningAnt )
formiga_c.x = display.contentCenterX+(2*display.contentCenterX/3)
formiga_c.y = display.contentCenterY
formiga_c.vida = 1
formiga_c:play()




--local linha1 = display.newLine(display.contentWidth/3,0,display.contentWidth/3,display.contentHeight)
--linha1.strokeWidth = 4
--linha1:setStrokeColor( 0.5, 0.5, 1, 0.5 )

--local linha2 = display.newLine(2*display.contentWidth/3,0,2*display.contentWidth/3,display.contentHeight)
--linha2:setStrokeColor( 0.5, 0.5, 1, 0.5 )
--linha2.strokeWidth = 4





function ChamaPontuacao()

	local FundoChannel = audio.pause( FundoSound )

			local Parametros = {
			pontos_p = pontos
			}
			composer.gotoScene( "pontuacao",{ effect="fade", time=800, params=Parametros })

			scene:addEventListener( "hide", scene )
			composer.hideOverlay( "main", 400 )
			composer.removeScene( "main")
			timer.pause( timer_muda_local )
end

function BatidaNaMadeira()

end


local function onObjectTouch( self, event )
    if ( event.phase == "began" ) then

		self.vida = self.vida-1 

		self:setFillColor( 1, 0, 0.5 )

    	if(self.vida < 1 and self.vida ~= 999) then 
    		
    		gosma.x = self.x
       		gosma.y = self.y

        	
        	self.y = -100
        	self:setFillColor( 1, 1, 1 )

        	
       		self.vida = self.vida+(1+math.floor(pontos/30)) 

			pontos = pontos+1;
        	
			pontuacao.text = "Pontos: "..pontos

			
			local SplashChannel = audio.play( SplashSound )
    	end
    end
    return true
end


function muda_local()
	
	formiga_a.y = formiga_a.y+1+math.random(0,pontos/10) 
	formiga_b.y = formiga_b.y+1+math.random(0,pontos/10) 
	formiga_c.y = formiga_c.y+1+math.random(0,pontos/10)

	
		if(formiga_a.y >= display.contentHeight) then
			ChamaPontuacao()
			formiga_a.y = -100
			formiga_a.vida = (1+math.floor(pontos/30))
			formiga_a:setFillColor( 1, 1, 1 )
			pontos = 0;
		end
		if(formiga_b.y >= display.contentHeight) then
			ChamaPontuacao()
			formiga_b.y = -100
			formiga_b.vida = (1+math.floor(pontos/30))
			formiga_b:setFillColor( 1, 1, 1 )
			pontos = 0;
		end
		if(formiga_c.y >= display.contentHeight) then
			ChamaPontuacao()
			formiga_c.y = -100
			formiga_c.vida = (1+math.floor(pontos/30))
			formiga_c:setFillColor( 1, 1, 1 )
			pontos = 0;

		end
end



formiga_a.touch = onObjectTouch
formiga_a:addEventListener( "touch", formiga_a )

formiga_b.touch = onObjectTouch
formiga_b:addEventListener( "touch", formiga_b )

formiga_c.touch = onObjectTouch
formiga_c:addEventListener( "touch", formiga_c )

madeira.touch = BatidaNaMadeira
madeira:addEventListener( "touch", madeira )



timer_muda_local = timer.performWithDelay(8, muda_local,0)

return scene