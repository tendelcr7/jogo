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

local madeira = display.newImageRect("sprites/madeira.jpg",(4999/8)+500,(4999/8))
madeira.x = display.contentCenterX
madeira.y = display.contentCenterY


local texto_pontos = display.newText( "Já vai?", 0, 0,"Arial")



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


texto_pontos:setFillColor( 1,0.75,0 )
texto_pontos.x = display.contentCenterX
texto_pontos.y = display.contentCenterY-150
texto_pontos:scale( 1.5, 1.5 )

local function onObjectTouch( self, event )
    if ( event.phase == "began" ) then

texto_pontos.text = "Tchau!"

    	if(self.nome == "menu")then
			composer.gotoScene( "menu")
		else
			composer.gotoScene( "main")
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

