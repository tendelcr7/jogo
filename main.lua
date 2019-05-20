-----------------------------------------------------------------------------------------
--
-- pontuacao.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )


local scene = composer.newScene()

composer.removeScene( "menu" )



local fundo = display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth*2,display.contentHeight*2)
fundo:setFillColor( 0.5, 0.5, 0.5 )

local madeira = display.newImageRect("sprites/grass.jpg",(800),(600))
madeira.x = display.contentCenterX
madeira.y = display.contentCenterY

local logo = display.newImageRect("sprites/logo.png",170,170)
logo.x = display.contentCenterX
logo.y = display.contentCenterY-170
logo.stroke = paint
logo.strokeWidth = 4



local texto_pontos = display.newText( "Ant Exterminator", 0, 0,"Arial")

local FundoSound = audio.loadSound( "sfx/fundo.wav" )
local FundoChannel = audio.play( FundoSound )

local again = display.newImageRect("sprites/play.png",820/6,446/6)
again.x = display.contentCenterX
again.y = display.contentCenterY
again.nome = "again"

local menu = display.newImageRect("sprites/sair.png",820/6,446/6)
menu.x = display.contentCenterX
menu.y = display.contentCenterY+80
menu.nome = "menu"


function scene:create( event )

end


scene:addEventListener( "create" )


texto_pontos:setFillColor( 1,1,1 )
texto_pontos.x = display.contentCenterX
texto_pontos.y = display.contentCenterY-70
texto_pontos:scale( 1, 1 )

local function onObjectTouch( self, event )
    if ( event.phase == "began" ) then

		local FundoChannel = audio.pause( FundoSound )

		local PlinSound = audio.loadSound( "sfx/SPLASH_Sound.wav" )
		local PlinChannel = audio.play( PlinSound )

    	if(self.nome == "menu")then
			composer.gotoScene( "menu")
		else
			composer.gotoScene( "fase")
    	end
			
		composer.hideOverlay( "pontuacao", 400 )
		composer.removeScene( "pontuacao")
	end
return true
end

again.touch = onObjectTouch
again:addEventListener( "touch", again )


menu.touch = onObjectTouch
menu:addEventListener( "touch", menu )

return scene

