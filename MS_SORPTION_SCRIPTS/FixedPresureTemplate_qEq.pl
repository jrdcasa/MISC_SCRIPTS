#!perl

use strict;
use Getopt::Long;
use MaterialsScript qw(:all);

my $doc =$Documents{"#FRAMEWORK#"};

my $sorptionFixedPressure = Modules->Sorption->FixedPressure;
my $component1 = $Documents{"#ADSORBATE#"};
$sorptionFixedPressure->AddComponent($component1);
$sorptionFixedPressure->Fugacity($component1) = #PRESS#;
my $results = $sorptionFixedPressure->Run($doc, Settings(
	CurrentForcefield => 'pcff', 
	ChargeAssignment => 'Charge using QEq', 
	'3DPeriodicElectrostaticEwaldSumAccuracy' => 1e-005, 
	'3DPeriodicvdWAtomCubicSplineCutOff' => 12.5, 
	'3DPeriodicvdWChargeGroupCubicSplineCutOff' => 12.5, 
	NumEquilibrationSteps => 1000000, 
	NumProductionSteps => 10000000, 
	SnapshotInterval => 10000, 
	ReturnLowEnergyConfigurations => 'Yes', 
	NumLowEnergyConfigurations => 20, 
	RetainIntermediateFiles => 'Yes', 
    CalculateProbabilityFields => 'Yes',
    CalculateEnergyFields => 'Yes',
    CalculateEnergyDistributions => 'Yes',
    Temperature => #TEMP#,
    PropertyCalculationInterval => 25));
