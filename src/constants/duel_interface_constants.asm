; wCardPageNumber constants
DEF CARDPAGE_POKEMON_OVERVIEW    EQU $01
DEF CARDPAGE_POKEMON_ATTACK1_1   EQU $02
DEF CARDPAGE_POKEMON_ATTACK1_2   EQU $03
DEF CARDPAGE_POKEMON_ATTACK2_1   EQU $04
DEF CARDPAGE_POKEMON_ATTACK2_2   EQU $05
DEF CARDPAGE_POKEMON_DESCRIPTION EQU $06
DEF CARDPAGE_ENERGY              EQU $09
DEF CARDPAGE_TRAINER_1           EQU $0d
DEF CARDPAGE_TRAINER_2           EQU $0e

; wAttackPageNumber constants
DEF ATTACKPAGE_ATTACK1_1 EQU $00
DEF ATTACKPAGE_ATTACK1_2 EQU $01
DEF ATTACKPAGE_ATTACK2_1 EQU $02
DEF ATTACKPAGE_ATTACK2_2 EQU $03

; wCardPageType constants
DEF CARDPAGETYPE_NOT_PLAY_AREA EQU $00
DEF CARDPAGETYPE_PLAY_AREA     EQU $01

; card type header constants ($10-tile headers in DuelCardHeaderGraphics)
DEF HEADER_TRAINER EQU $00
DEF HEADER_ENERGY  EQU $01
DEF HEADER_POKEMON EQU $02

; Box message id's
	const_def
	const BOXMSG_PLAYERS_TURN
	const BOXMSG_OPPONENTS_TURN
	const BOXMSG_BETWEEN_TURNS
	const BOXMSG_DECISION
	const BOXMSG_BENCH_POKEMON
	const BOXMSG_ARENA_POKEMON
	const BOXMSG_COIN_TOSS

; wDuelDisplayedScreen constants
DEF DUEL_MAIN_SCENE     EQU $01
DEF PLAY_AREA_CARD_LIST EQU $02
DEF UNKNOWN_SCREEN_4    EQU $04 ; used for some animations
DEF UNKNOWN_SCREEN_5    EQU $05 ; used for some animations
DEF COIN_TOSS           EQU $06
DEF DRAW_CARDS          EQU $07
DEF LARGE_CARD_PICTURE  EQU $08
DEF SHUFFLE_DECK        EQU $09
DEF CHECK_PLAY_AREA     EQU $0a

; wCardListItemSelectionMenuType constants
;NONE        EQU $00
DEF PLAY_CHECK   EQU $01
DEF SELECT_CHECK EQU $02

; wInPlayAreaCurPosition constants
	const_def
	const INPLAYAREA_PLAYER_BENCH_1      ; $00
	const INPLAYAREA_PLAYER_BENCH_2      ; $01
	const INPLAYAREA_PLAYER_BENCH_3      ; $02
	const INPLAYAREA_PLAYER_BENCH_4      ; $03
	const INPLAYAREA_PLAYER_BENCH_5      ; $04
	const INPLAYAREA_PLAYER_ACTIVE       ; $05
	const INPLAYAREA_PLAYER_HAND         ; $06
	const INPLAYAREA_PLAYER_DISCARD_PILE ; $07
	const INPLAYAREA_OPP_ACTIVE          ; $08
	const INPLAYAREA_OPP_HAND            ; $09
	const INPLAYAREA_OPP_DISCARD_PILE    ; $0a
	const INPLAYAREA_OPP_BENCH_1         ; $0b
	const INPLAYAREA_OPP_BENCH_2         ; $0c
	const INPLAYAREA_OPP_BENCH_3         ; $0d
	const INPLAYAREA_OPP_BENCH_4         ; $0e
	const INPLAYAREA_OPP_BENCH_5         ; $0f
DEF NUM_INPLAYAREA_POSITIONS EQU const_value
	const INPLAYAREA_PLAYER_PLAY_AREA    ; $10
	const INPLAYAREA_OPP_PLAY_AREA       ; $11
