EffectCommands::
; Each attack has a two-byte effect pointer (attack's 7th param) that points to one of these structures.
; Similarly, trainer cards have a two-byte pointer (7th param) to one of these structures, which determines the card's function.
; Energy cards also point to one of these, but their data is just $00.
;	db EFFECTCMDTYPE_* ($01 - $0a)
;	dw Function
;	...
;	db $00

; Commands are associated to a time or a scope (EFFECTCMDTYPE_*) that determines when their function is executed during the turn.
; - EFFECTCMDTYPE_INITIAL_EFFECT_1: Executed right after attack or trainer card is used. Bypasses Smokescreen and Sand Attack effects.
; - EFFECTCMDTYPE_INITIAL_EFFECT_2: Executed right after attack, Pokemon Power, or trainer card is used.
; - EFFECTCMDTYPE_DISCARD_ENERGY: For attacks or trainer cards that require putting one or more attached energy cards into the discard pile.
; - EFFECTCMDTYPE_REQUIRE_SELECTION: For attacks, Pokemon Powers, or trainer cards requiring the user to select a card (from e.g. play area screen or card list).
; - EFFECTCMDTYPE_BEFORE_DAMAGE: Effect command of an attack executed prior to the damage step. For trainer card or Pokemon Power, usually the main effect.
; - EFFECTCMDTYPE_AFTER_DAMAGE: Effect command executed after the damage step.
; - EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN: For attacks that may result in the defending Pokemon being switched out. Called only for AI-executed attacks.
; - EFFECTCMDTYPE_PKMN_POWER_TRIGGER: Pokemon Power effects that trigger the moment the Pokemon card is played.
; - EFFECTCMDTYPE_AI: Used for AI scoring.
; - EFFECTCMDTYPE_AI_SELECTION: When AI is required to select a card

; Attacks that have an EFFECTCMDTYPE_REQUIRE_SELECTION also must have either an EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN or an
; EFFECTCMDTYPE_AI_SELECTION (for anything not involving switching the defending Pokemon), to handle selections involving the AI.

; Similar attack effects of different Pokemon cards all point to a different command list,
; even though in some cases their commands and function pointers match.

; Function name examples
;	PoisonEffect                     ; generic effect shared by multiple attacks.
;	Paralysis50PercentEffect         ;
;	KakunaStiffenEffect              ; unique effect from an attack known by multiple cards.
;	MetapodStiffenEffect             ;
;	AcidEffect                       ; unique effect from an attack known by a single card
;	FoulOdorEffect                   ;
;	SpitPoison_Poison50PercentEffect ; unique effect made of more than one command.
;	SpitPoison_AIEffect              ;
 
EkansSpitPoisonEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpitPoison_Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, SpitPoison_AIEffect
	db  $00

ArbokTerrorStrikeEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TerrorStrike_SwitchDefendingPokemon
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, TerrorStrike_50PercentSelectSwitchPokemon
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, TerrorStrike_50PercentSelectSwitchPokemon
	db  $00

Poison50PercentEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Poison50PercentEffect
	dbw EFFECTCMDTYPE_AI, Poison50Percent_AIEffect
	db  $00

LureEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, OpBenchCheckEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SwitchDefendingPokemon
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Lure_SelectSwitchPokemon
	dbw EFFECTCMDTYPE_AI_SELECTION, GetBenchPokemonWithLowestHPEffect
	db  $00

VictreebelAcidEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AcidEffect
	db  $00

Paralysis50PercentEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Paralysis50PercentEffect
	db  $00

GloomFoulOdorEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FoulOdorEffect
	db  $00

ScytherSwordsDanceEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SwordsDanceEffect
	db  $00

SupersonicEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SupersonicEffect
	db  $00

LeechLifeEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, LeechLifeEffect
	db  $00

DoubleAttackX30EffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DoubleAttackX30Effect
	dbw EFFECTCMDTYPE_AI, DoubleAttackX30_AIEffect
	db  $00

KoffingFoulGasEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FoulGas_PoisonOrConfusionEffect
	dbw EFFECTCMDTYPE_AI, FoulGas_AIEffect
	db  $00

StiffenEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StiffenEffect
	db  $00

OddishSproutEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CheckDeckAndPlayArea
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PutInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Sprout_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Sprout_AISelectEffect
	db  $00

ExeggutorTeleportEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Teleport_CheckBench
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Teleport_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Teleport_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Teleport_AISelectEffect
	db  $00

ExeggutorBigEggsplosionEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BigEggsplosion_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, BigEggsplosion_AIEffect
	db  $00

NidokingThrashEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Thunderpunch_ModifierEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Thunderpunch_RecoilEffect
	dbw EFFECTCMDTYPE_AI, Thrash_AIEffect
	db  $00

NidokingToxicEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Toxic_DoublePoisonEffect
	dbw EFFECTCMDTYPE_AI, Toxic_AIEffect
	db  $00

NidoqueenBoyfriendsEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BoyfriendsEffect
	db  $00

TripleAttackX10EffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TripleAttackX10_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, TripleAttackX10_AIEffect
	db  $00

NidoranFCallForFamilyEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CheckDeckAndPlayArea
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PutInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, NidoranFCallForFamily_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, NidoranFCallForFamily_AISelectEffect
	db  $00

NidoranMHornHazardEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HornHazard_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_AI, HornHazard_AIEffect
	db  $00

WhirlwindEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Whirlwind_SwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Whirlwind_CheckBench
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Whirlwind_CheckBench
	db  $00

MegaDrainEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MegaDrainEffect
	db  $00

SporeEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SleepEffect
	db  $00

InflictPoisonEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoisonEffect
	dbw EFFECTCMDTYPE_AI, Poison_AIEffect
	db  $00

LeechSeedEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, LeechSeedEffect
	db  $00

VenusaurEnergyTransEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, EnergyTrans_CheckPlayArea
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EnergyTrans_TransferEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, EnergyTrans_AIEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergyTrans_PrintProcedure
	db  $00

MinimizeEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MinimizeEffect
	db  $00

MukToxicGasEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ToxicGasEffect
	db  $00

BellsproutCallForFamilyEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CheckDeckAndPlayArea
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PutInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, BellsproutCallForFamily_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, BellsproutCallForFamily_AISelectEffect
	db  $00

Selfdestruct60DMGEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Selfdestruct60DMGEffect
	db  $00

VenomothShiftEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Shift_OncePerTurnCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Shift_ChangeColorEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Shift_PlayerSelectEffect
	db  $00

VenomothVenomPowderEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VenomPowder_PoisonConfusion50PercentEffect
	dbw EFFECTCMDTYPE_AI, VenomPowder_AIEffect
	db  $00

VileplumeHealEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Heal_OncePerTurnCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Heal_RemoveDamageEffect
	db  $00

VileplumePetalDanceEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PetalDance_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, PetalDance_AIEffect
	db  $00

VenusaurSolarPowerEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SolarPower_CheckUse
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SolarPower_RemoveStatusEffect
	db  $00

OmastarWaterGunEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OmastarWaterGunEffect
	dbw EFFECTCMDTYPE_AI, OmastarWaterGunEffect
	db  $00

OmanyteClairvoyanceEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ClairvoyanceEffect
	db  $00

OmanyteWaterGunEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, OmanyteWaterGunEffect
	dbw EFFECTCMDTYPE_AI, OmanyteWaterGunEffect
	db  $00

BlastoiseRainDanceEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, RainDanceEffect
	db  $00

BlastoiseHydroPumpEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HydroPumpEffect
	dbw EFFECTCMDTYPE_AI, HydroPumpEffect
	db  $00

FlailEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Flail_HPCheck
	dbw EFFECTCMDTYPE_AI, Flail_AIEffect
	db  $00

KrabbyCallForFamilyEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CheckDeckAndPlayArea
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PutInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, KrabbyCallForFamily_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, KrabbyCallForFamily_AISelectEffect
	db  $00

PsyduckHeadacheEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HeadacheEffect
	db  $00

HyperBeamEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, HyperBeam_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, HyperBeam_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, HyperBeam_AISelectEffect
	db  $00

SeadraWaterGunEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SeadraWaterGunEffect
	dbw EFFECTCMDTYPE_AI, SeadraWaterGunEffect
	db  $00

ShellderHideInShellEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HideInShellEffect
	db  $00

VaporeonWaterGunEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, VaporeonWaterGunEffect
	dbw EFFECTCMDTYPE_AI, VaporeonWaterGunEffect
	db  $00

StarmieRecoverEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, StarmieRecover_CheckEnergyHP
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, StarmieRecover_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, StarmieRecover_HealEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, StarmieRecover_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, StarmieRecover_AISelectEffect
	db  $00

WithdrawEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, WithdrawEffect
	db  $00

PoliwrathWaterGunEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwrathWaterGunEffect
	dbw EFFECTCMDTYPE_AI, PoliwrathWaterGunEffect
	db  $00

PoliwagWaterGunEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PoliwagWaterGunEffect
	dbw EFFECTCMDTYPE_AI, PoliwagWaterGunEffect
	db  $00

CloysterClampEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ClampEffect
	db  $00

ArticunoBlizzardEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Blizzard_BenchDamage50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Blizzard_BenchDamageEffect
	db  $00

TentacoolCowardiceEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Cowardice_Check
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Cowardice_RemoveFromPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Cowardice_PlayerSelectEffect
	db  $00

LaprasWaterGunEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LaprasWaterGunEffect
	dbw EFFECTCMDTYPE_AI, LaprasWaterGunEffect
	db  $00

ArticunoQuickfreezeEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Quickfreeze_InitialEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Quickfreeze_Paralysis50PercentEffect
	db  $00

ArticunoIceBreathEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, IceBreath_ZeroDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, IceBreath_RandomPokemonDamageEffect
	db  $00

VaporeonFocusEnergyEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FocusEnergyEffect
	db  $00

ArcanineTakeDownEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, TakeDownEffect
	db  $00

QuickAttackEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, QuickAttack_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, QuickAttack_AIEffect
	db  $00

ArcanineFlamesOfRageEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FlamesOfRage_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, FlamesOfRage_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Rage_DamageBoostEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, FlamesOfRage_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, FlamesOfRage_AISelectEffect
	dbw EFFECTCMDTYPE_AI, Rage_AIEffect
	db  $00

StompEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Stomp_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, Stomp_AIEffect
	db  $00

AgilityEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, AgilityEffect
	db  $00

EmberEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Fire_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Fire_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Discard1EnergyEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Fire_AISelectEffect
	db  $00

MoltresWildfireEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Fire_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Wildfire_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Wildfire_DiscardDeckEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Wildfire_DiscardEnergyEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Wildfire_AISelectEffect
	db  $00

MoltresLv35DiveBombEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DiveBomb_Success50PercentEffect
	dbw EFFECTCMDTYPE_AI, MoltresLv35DiveBomb_AIEffect
	db  $00

SmokescreenEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SmokescreenEffect
	db  $00

CharizardEnergyBurnEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergyBurnEffect
	db  $00

CharizardFireSpinEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FireSpin_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, FireSpin_PlayerSelectEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, FireSpin_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, FireSpin_AISelectEffect
	db  $00

ConfuseRayEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Confusion50PercentEffect
	db  $00

RageEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Rage_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, Rage_AIEffect
	db  $00

NinetalesMixUpEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MixUpEffect
	db  $00

NinetalesDancingEmbersEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DancingEmbers_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, DancingEmbers_AIEffect
	db  $00

MoltresFiregiverEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Firegiver_InitialEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, Firegiver_AddToHandEffect
	db  $00

MoltresLv37DiveBombEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DiveBomb_Success50PercentEffect
	dbw EFFECTCMDTYPE_AI, MoltresLv37DiveBomb_AIEffect
	db  $00

GengarCurseEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Curse_CheckDamageAndBench
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Curse_TransferDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Curse_PlayerSelectEffect
	db  $00

GastlySleepingGasEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SleepingGasEffect
	db  $00

GastlyDestinyBondEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DestinyBond_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DestinyBond_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DestinyBond_DestinyBondEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, DestinyBond_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DestinyBond_AISelectEffect
	db  $00

GastlyEnergyConversionEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergyConversion_CheckEnergy
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, EnergyConversion_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergyConversion_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, EnergyConversion_AISelectEffect
	db  $00

HaunterDreamEaterEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DreamEaterEffect
	db  $00

HaunterTransparencyEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, TransparencyEffect
	db  $00

HypnoProphecyEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Prophecy_CheckDeck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Prophecy_ReorderDeckEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Prophecy_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Prophecy_AISelectEffect
	db  $00

MrMimeInvisibleWallEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, InvisibleWallEffect
	db  $00

MrMimeMeditateEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MrMimeMeditate_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, MrMimeMeditate_AIEffect
	db  $00

AlakazamDamageSwapEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DamageSwap_CheckDamage
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DamageSwap_SelectAndSwapEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DamageSwap_SwapEffect
	db  $00

MewPsywaveEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PsywaveEffect
	db  $00

MewDevolutionBeamEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DevolutionBeam_CheckPlayArea
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DevolutionBeam_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DevolutionBeam_LoadAnimation
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, DevolutionBeam_DevolveEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, DevolutionBeam_AISelectEffect
	db  $00

MewNeutralizingShieldEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, NeutralizingShieldEffect
	db  $00

MewtwoPsychicEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Psychic_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, Psychic_AIEffect
	db  $00

MewtwoBarrierEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Barrier_CheckEnergy
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Barrier_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Barrier_BarrierEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Barrier_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Barrier_AISelectEffect
	db  $00

MewtwoAltLV60EnergyAbsorptionEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MewtwoAltLV60EnergyAbsorption_CheckDiscardPile
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MewtwoAltLV60EnergyAbsorption_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MewtwoAltLV60EnergyAbsorption_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MewtwoAltLV60EnergyAbsorption_AISelectEffect
	db  $00

MewtwoLv60EnergyAbsorptionEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, MewtwoLv60EnergyAbsorption_CheckDiscardPile
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MewtwoLv60EnergyAbsorption_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MewtwoLv60EnergyAbsorption_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MewtwoLv60EnergyAbsorption_AISelectEffect
	db  $00

SlowbroStrangeBehaviorEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, StrangeBehavior_CheckDamage
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StrangeBehavior_SelectAndSwapEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, StrangeBehavior_SwapEffect
	db  $00

SlowpokeSpacingOutEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SpacingOut_CheckDamage
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SpacingOut_Success50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SpacingOut_HealEffect
	db  $00

SlowpokeScavengeEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Scavenge_CheckDiscardPile
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Scavenge_PlayerSelectEnergyEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Scavenge_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Scavenge_PlayerSelectTrainerEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, Scavenge_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Scavenge_AISelectEffect
	db  $00

AmnesiaEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Amnesia_CheckAttacks
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PlayerPickAttackForAmnesia
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ApplyAmnesiaToAttack
	dbw EFFECTCMDTYPE_AI_SELECTION, Amnesia_AISelectEffect
	db  $00

KadabraRecoverEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KadabraRecover_CheckEnergyHP
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, KadabraRecover_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, KadabraRecover_HealEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, KadabraRecover_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, KadabraRecover_AISelectEffect
	db  $00

JynxDoubleslapEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JynxDoubleslap_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, JynxDoubleslap_AIEffect
	db  $00

JynxMeditateEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JynxMeditate_DamageBoostEffect
	dbw EFFECTCMDTYPE_AI, JynxMeditate_AIEffect
	db  $00

MewMysteryAttackEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MysteryAttack_RandomEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MysteryAttack_RecoverEffect
	dbw EFFECTCMDTYPE_AI, MysteryAttack_AIEffect
	db  $00

GeodudeStoneBarrageEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StoneBarrage_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, StoneBarrage_AIEffect
	db  $00

PrimeapeTantrumEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TantrumEffect
	db  $00

MachampStrikesBackEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, StrikesBackEffect
	db  $00

KabutoKabutoArmorEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, KabutoArmorEffect
	db  $00

CuboneSnivelEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SnivelEffect
	db  $00

MarowakCallforFriendEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, CheckDeckAndPlayArea
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PutInPlayAreaEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, MarowakCallForFamily_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, MarowakCallForFamily_AISelectEffect
	db  $00

MachokeKarateChopEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, KarateChop_DamageSubtractionEffect
	dbw EFFECTCMDTYPE_AI, KarateChop_AIEffect
	db  $00

SubmissionEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SubmissionEffect
	db  $00

Selfdestruct100DMGEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Selfdestruct100DMGEffect
	db  $00

HardenEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, HardenEffect
	db  $00

RhydonRamEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Ram_RecoilSwitchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Ram_SelectSwitchEffect
	dbw EFFECTCMDTYPE_AI_SWITCH_DEFENDING_PKMN, Ram_SelectSwitchEffect
	db  $00

RhyhornLeerEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LeerEffect
	db  $00

HitmonleeStretchKickEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, OpBenchCheckEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, StretchKick_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, StretchKick_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, GetBenchPokemonWithLowestHPEffect
	db  $00

SandshrewSandAttackEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SandAttackEffect
	db  $00

TripleAttackX20EffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TripleAttackX20_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, TripleAttackX20_AIEffect
	db  $00

DugtrioEarthquakeEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, EarthquakeEffect
	db  $00

AerodactylPrehistoricPowerEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PrehistoricPowerEffect
	db  $00

MankeyPeekEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Peek_OncePerTurnCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Peek_SelectEffect
	db  $00

MarowakBoneAttackEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BoneAttackEffect
	db  $00

MarowakWailEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Wail_BenchCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Wail_FillBenchEffect
	db  $00

ElectabuzzThunderpunchEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Thunderpunch_ModifierEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Thunderpunch_RecoilEffect
	dbw EFFECTCMDTYPE_AI, Thunderpunch_AIEffect
	db  $00

ElectabuzzLightScreenEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LightScreenEffect
	db  $00

Selfdestruct40DMGEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Selfdestruct40DMGEffect
	db  $00

ZapdosThunderboltEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ThunderboltEffect
	db  $00

ZapdosThunderstormEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ThunderstormEffect
	db  $00

JolteonPinMissileEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PinMissile_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, PinMissile_AIEffect
	db  $00

FlyingPikachuFlyEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Fly_Success50PercentEffect
	dbw EFFECTCMDTYPE_AI, Fly_AIEffect
	db  $00

PikachuThunderJoltEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ThunderJolt_Recoil50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ThunderJolt_RecoilEffect
	db  $00

SparkEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Deal10DamageBenchEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Spark_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Spark_AISelectEffect
	db  $00

GrowlEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GrowlEffect
	db  $00

ElectrodeChainLightningEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ChainLightningEffect
	db  $00

ThunderEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Thunder_Recoil50PercentEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Thunder_RecoilEffect
	db  $00

RaichuGigashockEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Gigashock_BenchDamageEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Gigashock_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Gigashock_AISelectEffect
	db  $00

Selfdestruct80DMGEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Selfdestruct80DMGEffect
	db  $00

MagnetonSonicboomEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MagnetonSonicboom_UnaffectedByColorEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagnetonSonicboom_NullEffect
	dbw EFFECTCMDTYPE_AI, MagnetonSonicboom_UnaffectedByColorEffect
	db  $00

ZapdosPealOfThunderEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PealOfThunder_InitialEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, PealOfThunder_RandomlyDamageEffect
	db  $00

ZapdosBigThunderEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, BigThunderEffect
	db  $00

MagnemiteMagneticStormEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MagneticStormEffect
	db  $00

ElectrodeSonicboomEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ElectrodeSonicboom_UnaffectedByColorEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ElectrodeSonicboom_NullEffect
	dbw EFFECTCMDTYPE_AI, ElectrodeSonicboom_UnaffectedByColorEffect
	db  $00

ElectrodeEnergySpikeEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergySpike_DeckCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, EnergySpike_AttachEnergyEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergySpike_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, EnergySpike_AISelectEffect
	db  $00

JolteonDoubleKickEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, JolteonDoubleKick_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, JolteonDoubleKick_AIEffect
	db  $00

EeveeTailWagEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TailWagEffect
	db  $00

DragoniteStepInEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, StepIn_BenchCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, StepIn_SwitchEffect
	db  $00

DragoniteLv45SlamEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DragoniteLv45Slam_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, DragoniteLv45Slam_AIEffect
	db  $00

SnorlaxThickSkinnedEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ThickSkinnedEffect
	db  $00

FarfetchdLeekSlapEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, LeekSlap_OncePerDuelCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LeekSlap_NoDamage50PercentEffect
	dbw EFFECTCMDTYPE_DISCARD_ENERGY, LeekSlap_SetUsedThisDuelFlag
	dbw EFFECTCMDTYPE_AI, LeekSlap_AIEffect
	db  $00

KangaskhanFetchEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, FetchEffect
	db  $00

KangaskhanCometPunchEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, CometPunch_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, CometPunch_AIEffect
	db  $00

TaurosRampageEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Rampage_Confusion50PercentEffect
	dbw EFFECTCMDTYPE_AI, Rampage_AIEffect
	db  $00

DoduoFuryAttackEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FuryAttack_MultiplierEffect
	dbw EFFECTCMDTYPE_AI, FuryAttack_AIEffect
	db  $00

DodrioRetreatAidEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, RetreatAidEffect
	db  $00

MeowthPayDayEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PayDayEffect
	db  $00

ClefableMetronomeEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ClefableMetronome_CheckAttacks
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ClefableMetronome_UseAttackEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, ClefableMetronome_AISelectEffect
	db  $00

PidgeotHurricaneEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, HurricaneEffect
	db  $00

MirrorMoveEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PidgeottoMirrorMove_InitialEffect1
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PidgeottoMirrorMove_InitialEffect2
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PidgeottoMirrorMove_BeforeDamage
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, PidgeottoMirrorMove_AfterDamage
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PidgeottoMirrorMove_PlayerSelection
	dbw EFFECTCMDTYPE_AI_SELECTION, PidgeottoMirrorMove_AISelection
	dbw EFFECTCMDTYPE_AI, PidgeottoMirrorMove_AIEffect
	db  $00

ClefairySingEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SingEffect
	db  $00

ClefairyMetronomeEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ClefairyMetronome_CheckAttacks
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ClefairyMetronome_UseAttackEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, ClefairyMetronome_AISelectEffect
	db  $00

WigglytuffDoTheWaveEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DoTheWaveEffect
	dbw EFFECTCMDTYPE_AI, DoTheWaveEffect
	db  $00

JigglypuffFirstAidEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FirstAid_DamageCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, FirstAid_HealEffect
	db  $00

PersianPounceEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PounceEffect
	db  $00

PorygonConversion1EffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Conversion1_WeaknessCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Conversion1_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Conversion1_ChangeWeaknessEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Conversion1_AISelectEffect
	db  $00

PorygonConversion2EffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Conversion2_ResistanceCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Conversion2_PlayerSelectEffect
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Conversion2_ChangeResistanceEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, Conversion2_AISelectEffect
	db  $00

ChanseyScrunchEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ScrunchEffect
	db  $00

ChanseyDoubleEdgeEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ChanseyDoubleEdgeEffect
	db  $00

RaticateSuperFangEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperFang_HalfHPEffect
	dbw EFFECTCMDTYPE_AI, SuperFang_AIEffect
	db  $00

TrainerCardAsPokemonEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, TrainerCardAsPokemon_BenchCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, TrainerCardAsPokemon_DiscardEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, TrainerCardAsPokemon_PlayerSelectSwitch
	db  $00

DragoniteHealingWindEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, HealingWind_InitialEffect
	dbw EFFECTCMDTYPE_PKMN_POWER_TRIGGER, HealingWind_PlayAreaHealEffect
	db  $00

MeowthCatPunchEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, CatPunchEffect
	db  $00

DittoMorphEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, MorphEffect
	db  $00

PidgeotSlicingWindEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, SlicingWindEffect
	db  $00

PidgeotGaleEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Gale_LoadAnimation
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, Gale_SwitchEffect
	db  $00

JigglypuffFriendshipSongEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Max_BenchCheck
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, FriendshipSong_AddToBench50PercentEffect
	db  $00

JigglypuffExpandEffectCommands:
	dbw EFFECTCMDTYPE_AFTER_DAMAGE, ExpandEffect
	db  $00

DoubleColorlessEnergyEffectCommands:
	db  $00

PsychicEnergyEffectCommands:
	db  $00

FightingEnergyEffectCommands:
	db  $00

LightningEnergyEffectCommands:
	db  $00

WaterEnergyEffectCommands:
	db  $00

FireEnergyEffectCommands:
	db  $00

GrassEnergyEffectCommands:
	db  $00

SuperPotionEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SuperPotion_DamageEnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SuperPotion_PlayerSelectEffect
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperPotion_HealEffect
	db  $00

ImakuniEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ImakuniEffect
	db  $00

EnergyRemovalEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergyRemoval_EnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, EnergyRemoval_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EnergyRemoval_DiscardEffect
	dbw EFFECTCMDTYPE_AI_SELECTION, EnergyRemoval_AISelection
	db  $00

EnergyRetrievalEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, EnergyRetrieval_HandEnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, EnergyRetrieval_PlayerHandSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EnergyRetrieval_DiscardAndAddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergyRetrieval_PlayerDiscardPileSelection
	db  $00

EnergySearchEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, EnergySearch_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, EnergySearch_PlayerSelection
	db  $00

ProfessorOakEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ProfessorOakEffect
	db  $00

PotionEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PlayArea_DamageCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Potion_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Potion_HealEffect
	db  $00

GamblerEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GamblerEffect
	db  $00

ItemFinderEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ItemFinder_HandDiscardPileCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ItemFinder_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ItemFinder_DiscardAddToHandEffect
	db  $00

DefenderEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Defender_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Defender_AttachDefenderEffect
	db  $00

MysteriousFossilEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Max_BenchCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MysteriousFossil_PlaceInPlayAreaEffect
	db  $00

FullHealEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, FullHeal_StatusCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, FullHeal_ClearStatusEffect
	db  $00

ImposterProfessorOakEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ImposterProfessorOakEffect
	db  $00

ComputerSearchEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, ComputerSearch_HandDeckCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ComputerSearch_PlayerDiscardHandSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ComputerSearch_DiscardAddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, ComputerSearch_PlayerDeckSelection
	db  $00

ClefairyDollEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Max_BenchCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ClefairyDoll_PlaceInPlayAreaEffect
	db  $00

MrFujiEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Player_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, MrFuji_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, MrFuji_ReturnToDeckEffect
	db  $00

PlusPowerEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PlusPowerEffect
	db  $00

SwitchEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Player_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Switch_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Switch_SwitchEffect
	db  $00

PokemonCenterEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PlayArea_DamageCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonCenter_HealDiscardEnergyEffect
	db  $00

PokemonFluteEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonFlute_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PokemonFlute_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonFlute_PlaceInPlayAreaText
	db  $00

PokemonBreederEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonBreeder_HandPlayAreaCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PokemonBreeder_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonBreeder_EvolveEffect
	db  $00

ScoopUpEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Player_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, ScoopUp_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, ScoopUp_ReturnToHandEffect
	db  $00

PokemonTraderEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, PokemonTrader_HandDeckCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, PokemonTrader_PlayerHandSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokemonTrader_TradeCardsEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PokemonTrader_PlayerDeckSelection
	db  $00

PokedexEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Pokedex_OrderDeckCardsEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Pokedex_PlayerSelection
	db  $00

BillEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, BillEffect
	db  $00

LassEffectCommands:
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, LassEffect
	db  $00

MaintenanceEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Maintenance_HandCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Maintenance_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Maintenance_ReturnToDeckAndDrawEffect
	db  $00

PokeBallEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DeckCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, PokeBall_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, PokeBall_PlayerSelection
	db  $00

RecycleEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Recycle_DiscardPileCheck
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Recycle_AddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, Recycle_PlayerSelection
	db  $00

ReviveEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, Revive_BenchCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, Revive_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, Revive_PlaceInPlayAreaEffect
	db  $00

DevolutionSprayEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, DevolutionSpray_PlayAreaEvolutionCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, DevolutionSpray_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, DevolutionSpray_DevolutionEffect
	db  $00

SuperEnergyRemovalEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SuperEnergyRemoval_EnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SuperEnergyRemoval_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperEnergyRemoval_DiscardEffect
	db  $00

SuperEnergyRetrievalEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, SuperEnergyRetrieval_HandEnergyCheck
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, SuperEnergyRetrieval_PlayerHandSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, SuperEnergyRetrieval_DiscardAndAddToHandEffect
	dbw EFFECTCMDTYPE_REQUIRE_SELECTION, SuperEnergyRetrieval_PlayerDiscardPileSelection
	db  $00

GustOfWindEffectCommands:
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_1, OpBenchCheckEffect
	dbw EFFECTCMDTYPE_INITIAL_EFFECT_2, GustOfWind_PlayerSelection
	dbw EFFECTCMDTYPE_BEFORE_DAMAGE, GustOfWind_SwitchEffect
	db  $00
