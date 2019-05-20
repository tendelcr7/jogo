-----------------------------------------------------------------------------------------
--
-- pontuacao.lua
--
-----------------------------------------------------------------------------------------
local composer = require( "composer" )
local score = require( "score" )

local scene = composer.newScene()

composer.removeScene( "fase" )
score.init({})

local DerrotaSound = audio.loadSound( "sfx/derrota.wav" )
local DerrotaChannel = audio.play( DerrotaSound )


local fundo = display.newRect(display.contentCenterX,display.contentCenterY,display.contentWidth*2,display.contentHeight*2)
fundo:setFillColor( 0.5, 0.5, 0.5 )


local texto_pontos = display.newText( "Pontos: 0", 0, 0,"Arial")



local again = display.newImageRect("sprites/again.png",820/6,446/6)
again.x = display.contentCenterX
again.y = display.contentCenterY
again.nome = "again"

local sair = display.newImageRect("sprites/sair.png",820/6,446/6)
sair.x = display.contentCenterX
sair.y = display.contentCenterY+80
sair.nome = "sair"


function scene:create( event )
	if(event.params.pontos_p > score.load())then
		score.set("".. event.params.pontos_p )
		score.save()
	end

    texto_pontos.text = "   GAME OVER\n\nPontuação: "..event.params.pontos_p.."\nRecorde: "..score.load()
end
 

scene:addEventListener( "create" )


texto_pontos:setFillColor( 1,0.75,0 )
texto_pontos.x = display.contentCenterX
texto_pontos.y = display.contentCenterY-150
texto_pontos:scale( 1.5, 1.5 )

function ChamaMenu()

			composer.gotoScene( "main")

			composer.hideOverlay( "pontuacao", 400 )
			composer.removeScene( "pontuacao")
end

local function onObjectTouch( self, event )
    if ( event.phase == "began" ) then

    	local DerrotaChannel = audio.pause( DerrotaSound )

    	if(self.nome == "sair")then
			
			composer.gotoScene( "main")
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


sair.touch = onObjectTouch
sair:addEventListener( "touch", sair )

return scene

