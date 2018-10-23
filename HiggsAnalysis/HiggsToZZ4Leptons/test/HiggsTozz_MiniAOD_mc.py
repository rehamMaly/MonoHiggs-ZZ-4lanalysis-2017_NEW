import FWCore.ParameterSet.Config as cms

process = cms.Process('MonoHiggs')

# Complete Preselection Sequence for 4l analysis

process.load('Configuration/StandardSequences/Services_cff')
process.load('FWCore/MessageService/MessageLogger_cfi')

# import of standard configurations
process.load('Configuration/StandardSequences/Services_cff')
process.load('FWCore/MessageService/MessageLogger_cfi')
process.load('Configuration/Geometry/GeometryRecoDB_cff')
#process.load('Configuration.StandardSequences.MagneticField_38T_PostLS1_cff')#reham
process.load('Configuration.StandardSequences.MagneticField_cff') #reham
process.load('Configuration/StandardSequences/EndOfProcess_cff')
process.load('Configuration/StandardSequences/FrontierConditions_GlobalTag_condDBv2_cff')
process.load('Configuration/EventContent/EventContent_cff')


from Configuration.AlCa.GlobalTag_condDBv2 import GlobalTag
#process.GlobalTag = GlobalTag(process.GlobalTag, '80X_mcRun2_asymptotic_2016_TrancheIV_v7', '')
process.GlobalTag = GlobalTag(process.GlobalTag, '94X_mc2017_realistic_v13', '')#Reham Tag recommended for JEC 2017

# Random generator
process.RandomNumberGeneratorService = cms.Service("RandomNumberGeneratorService",
    calibratedPatElectrons = cms.PSet(
        initialSeed = cms.untracked.uint32(1),
        engineName = cms.untracked.string('TRandom3')
    )
)

process.load('HiggsAnalysis.HiggsToZZ4Leptons.bunchSpacingProducer_cfi')
#process.load('HiggsAnalysis.HiggsToZZ4Leptons.metFiltersMiniAOD_cff')

process.load('RecoMET.METFilters.metFilters_cff')
process.load('RecoMET.METFilters.BadPFMuonFilter_cfi')
process.load('RecoMET.METFilters.BadChargedCandidateFilter_cfi')

process.Path_BunchSpacingproducer=cms.Path(process.bunchSpacingProducer)

process.Flag_HBHENoiseFilter = cms.Path(process.HBHENoiseFilterResultProducer * process.HBHENoiseFilter)
process.Flag_HBHENoiseIsoFilter = cms.Path(process.HBHENoiseFilterResultProducer * process.HBHENoiseIsoFilter)
## process.Flag_CSCTightHaloFilter = cms.Path(process.CSCTightHaloFilter)                                                               
## process.Flag_CSCTightHaloTrkMuUnvetoFilter = cms.Path(process.CSCTightHaloTrkMuUnvetoFilter)                                           
## process.Flag_CSCTightHalo2015Filter = cms.Path(process.CSCTightHalo2015Filter)
process.Flag_globalTightHalo2016Filter = cms.Path(process.globalTightHalo2016Filter)      
## process.Flag_HcalStripHaloFilter = cms.Path(process.HcalStripHaloFilter)   
## process.Flag_hcalLaserEventFilter = cms.Path(process.hcalLaserEventFilter)                                                             
process.Flag_EcalDeadCellTriggerPrimitiveFilter = cms.Path(process.EcalDeadCellTriggerPrimitiveFilter)
## process.Flag_EcalDeadCellBoundaryEnergyFilter = cms.Path(process.EcalDeadCellBoundaryEnergyFilter) 
process.primaryVertexFilter.vertexCollection = cms.InputTag('offlineSlimmedPrimaryVertices')
process.Flag_goodVertices = cms.Path(process.primaryVertexFilter)

## process.Flag_trackingFailureFilter = cms.Path(process.goodVertices + process.trackingFailureFilter)                                    
#process.Flag_eeBadScFilter = cms.Path(process.eeBadScFilter)
process.BadPFMuonFilter.muons  = cms.InputTag("slimmedMuons")
process.Flag_BadPFMuonFilter = cms.Path(process.BadPFMuonFilter)
process.BadChargedCandidateFilter.muons  = cms.InputTag("slimmedMuons")
process.Flag_BadChargedCandidateFilter = cms.Path(process.BadChargedCandidateFilter) # Reham added for 2017

#///////////////////////////////
#new MET filter 2017 Reham

process.Flag_ecalBadCalibFilter = cms.Path(process.ecalBadCalibFilter) #new 2017


#/////////////////////////////////////////

## process.Flag_ecalLaserCorrFilter = cms.Path(process.ecalLaserCorrFilter)                                                               
## process.Flag_trkPOGFilters = cms.Path(process.trkPOGFilters)                                                                           
## process.Flag_chargedHadronTrackResolutionFilter = cms.Path(process.chargedHadronTrackResolutionFilter)                                 
## proces..Flag_muonBadTrackFilter = cms.Path(process.muonBadTrackFilter)                                                                 
## and the sub-filters                                                                                                                    
# process.Flag_trkPOG_manystripclus53X = cms.Path(~manystripclus53X)                                                                      
# process.Flag_trkPOG_toomanystripclus53X = cms.Path(~toomanystripclus53X)                                                                
# process.Flag_trkPOG_logErrorTooManyClusters = cms.Path(~logErrorTooManyClusters)            

process.goodOfflinePrimaryVerticestwo = cms.EDFilter("VertexSelector",
                                            src = cms.InputTag('offlineSlimmedPrimaryVertices'),
					    cut = cms.string('!isFake && ndof > 4 && abs(z) <= 24 && position.Rho <= 2'),
                                            filter = cms.bool(True)
                                        )
        


process.load('HiggsAnalysis/HiggsToZZ4Leptons/hTozzTo4leptonsMuonCalibrator_cfi')
process.hTozzTo4leptonsMuonCalibrator.isData = cms.bool(False) 

#process.load('EgammaAnalysis.ElectronTools.calibratedElectronsRun2_cfi')
#process.calibratedElectrons.isMC = cms.bool(True)

#/////////////////////////////////////////////////////////////
#Reham JEC

from PhysicsTools.PatAlgos.tools.jetTools import updateJetCollection

updateJetCollection(

process,
jetSource = cms.InputTag('slimmedJets'),
labelName = 'UpdatedJEC',
jetCorrections = ('AK4PFchs', cms.vstring(['L1FastJet', 'L2Relative', 'L3Absolute']), 'None')

)

process.jecSequence = cms.Sequence(process.patJetCorrFactorsUpdatedJEC * process.updatedPatJetsUpdatedJEC)

#///////////////////////////////////////////////////////////

#Reham to update the MET after updating the JEC

#from PhysicsTools.PatUtils.tools.runMETCorrectionsAndUncertainties import runMetCorAndUncFromMiniAOD

#runMetCorAndUncFromMiniAOD(process,
#                           isData=True, #(or False)
#                           pfCandColl=cms.InputTag("packedPFCandidates"),                        
#                           recoMetFromPFCs=True,
#                           CHS = True, #This is an important step and determines what type of jets to be reclustered
#                           reclusterJets = True,
#                           postfix="TEST"
#                           )


#update MET after update JEC 

from PhysicsTools.PatUtils.tools.runMETCorrectionsAndUncertainties import runMetCorAndUncFromMiniAOD

runMetCorAndUncFromMiniAOD(process,
                           isData=False, #(or False),
                           postfix = "TEST"
                           )

#/////////////////////////////////////////////////////
#Reham to add new instructiond for electron energy correction and smearing 

from RecoEgamma.EgammaTools.EgammaPostRecoTools import setupEgammaPostRecoSeq
setupEgammaPostRecoSeq(process,
                       runVID=False, #saves CPU time by not needlessly re-running VID
                       era='2017-Nov17ReReco')  


#///////////////////////////////////////////////////


process.load('HiggsAnalysis/HiggsToZZ4Leptons/hTozzTo4leptonsPreselection_data_noskim_cff') 

#@#process.calibratedPatElectrons.isMC = cms.bool(True)#Reham Run2 2017

process.hTozzTo4leptonsHLTInfo.TriggerResultsTag = cms.InputTag("TriggerResults","","HLT")
process.hTozzTo4leptonsCommonRootTreePresel.use2011EA = cms.untracked.bool(False)
process.hTozzTo4leptonsCommonRootTreePresel.triggerEvent  = cms.InputTag("hltTriggerSummaryAOD","","HLT")
process.hTozzTo4leptonsCommonRootTreePresel.fillPUinfo = True
process.hTozzTo4leptonsCommonRootTreePresel.fillHLTinfo = cms.untracked.bool(False)                                           
process.hTozzTo4leptonsCommonRootTreePresel.triggerFilter = cms.string('hltL3fL1sMu16Eta2p1L1f0L2f10QL3Filtered20Q')
process.hTozzTo4leptonsCommonRootTreePresel.triggerEleFilter = cms.string('hltL3fL1sMu16Eta2p1L1f0L2f10QL3Filtered20Q')
  #process.hTozzTo4leptonsCommonRootTreePresel.triggerFilterAsym = cms.vstring('hltDiMuonL3PreFiltered8','hltDiMuonL3p5PreFiltered8')
process.hTozzTo4leptonsCommonRootTreePresel.fillMCTruth  = cms.untracked.bool(True)    
process.hTozzTo4leptonsCommonRootTreePresel.isVBF  = cms.bool(False)
#//@
#This variable isData to apply muon calibrator inside commonRooTree.h and get the error on muon pT
process.hTozzTo4leptonsCommonRootTreePresel.isData = cms.bool(False)
#for LHE informations for Jets
#process.hTozzTo4leptonsCommonRootTreePresel.LHEProduct = cms.InputTag("source") #when commented, default=externalLHEProducer
process.hTozzTo4leptonsCommonRootTreePresel.LHEProduct = cms.InputTag("externalLHEProducer")# this inputTag depend on input mc sample 

process.genanalysis= cms.Sequence(
  process.hTozzTo4leptonsGenSequence                  *
  #       process.hTozzTo4leptonsMCGenFilter2e2mu             *
  #       process.hTozzTo4leptonsMCGenParticleListDrawer2e2mu *
  process.hTozzTo4leptonsMCDumper                     
 # process.hTozzTo4leptonsMCCP                         
  )

process.hTozzTo4leptonsSelectionPath = cms.Path(
  process.goodOfflinePrimaryVerticestwo     *
  process.genanalysis *
  process.jecSequence* #Reham to add JEC
  process.fullPatMetSequenceTEST * #Reham To update MET after update JEC
  process.egammaPostRecoSeq * #Reham to include electron smearing due to kink at 50 Gev in electron pt spectrum from old electron scale and smearing
  process.hTozzTo4leptonsSelectionSequenceData *
  process.hTozzTo4leptonsMatchingSequence * # for MC matching Reham
  process.hTozzTo4leptonsCommonRootTreePresel
  )

#///////////////////////////////////////////////////
#quark/gluon tagging
#process.load("CondCore.CondDB.CondDB_cfi")
#qgDatabaseVersion = '80X'
#process.QGPoolDBESSource = cms.ESSource("PoolDBESSource",
#                                        DBParameters = cms.PSet(messageLevel = cms.untracked.int32(1)),
#                                        timetype = cms.string('runnumber'),
#                                        toGet = cms.VPSet(
#                                          cms.PSet(
#                                             record = cms.string('QGLikelihoodRcd'),
#                                             tag    = cms.string('QGLikelihoodObject_'+qgDatabaseVersion+'_AK4PFchs'),
#                                             label  = cms.untracked.string('QGL_AK4PFchs')
#                                             ),
#                                          ),
#                                          connect = cms.string('sqlite:QGL_'+qgDatabaseVersion+'.db')
#)
#process.es_prefer_qg = cms.ESPrefer('PoolDBESSource','QGPoolDBESSource')

#//////////////////////////////////////////////////////////////////

process.load('HiggsAnalysis/HiggsToZZ4Leptons/hTozzTo4leptonsOutputModule_cff')
from HiggsAnalysis.HiggsToZZ4Leptons.hTozzTo4leptonsOutputModule_cff import *   #reham need to comment in run in crab
process.hTozzTo4leptonsSelectionOutputModuleNew = hTozzTo4leptonsSelectionOutputModule.clone()  #reham need to comment in run in crab
process.hTozzTo4leptonsSelectionOutputModuleNew.fileName = "MC_Synch_2017hTozzToLeptons.root"  #reham need to comment in run in crab

process.o = cms.EndPath (process.hTozzTo4leptonsSelectionOutputModuleNew ) #reham comment in run in crab
process.schedule = cms.Schedule( process.Path_BunchSpacingproducer,
                                 process.Flag_HBHENoiseFilter,
                                 process.Flag_HBHENoiseIsoFilter,
                                 process.Flag_globalTightHalo2016Filter,
                                 process.Flag_EcalDeadCellTriggerPrimitiveFilter,
                                 process.Flag_goodVertices,
#                                 process.Flag_eeBadScFilter,
#                                 process.Flag_BadPFMuonFilter,
#                                 process.Flag_BadChargedCandidateFilter,
                                 process.Flag_ecalBadCalibFilter, #new 2017
                                 process.hTozzTo4leptonsSelectionPath,
                                 process.o )


process.maxEvents = cms.untracked.PSet(input = cms.untracked.int32(1000))
process.options = cms.untracked.PSet(wantSummary = cms.untracked.bool(True))

process.source = cms.Source ("PoolSource",
                             
  fileNames = cms.untracked.vstring(
#'file:MC_Run2_Fall17_MINIAOD_WZTo3LNu_TuneCP5_13TeV_0CAA9BF8-6E07-E811-B8A8-0017A4771068.root' #2017
#'root://cms-xrd-global.cern.ch//store/mc/RunIIFall17MiniAODv2/GluGluToContinToZZTo2e2mu_13TeV_MCFM701_pythia8/MINIAODSIM/PU2017_12Apr2018_94X_mc2017_realistic_v14-v1/00000/02D14826-1442-E811-89BF-0242AC130002.root' #2017
'/store/mc/RunIIFall17MiniAOD/GluGluHToZZTo4L_M125_13TeV_powheg2_JHUGenV7011_pythia8/MINIAODSIM/94X_mc2017_realistic_v10-v1/40000/205E2EB6-2600-E811-A8D9-A0369FC5E090.root', #2017 Synchronization
#'/store/mc/RunIIFall17MiniAOD/VBF_HToZZTo4L_M125_13TeV_powheg2_JHUGenV7011_pythia8/MINIAODSIM/94X_mc2017_realistic_v10-v2/00000/E8505BB6-5F07-E811-B009-002590DE6E88.root',#2017 Synchronization
#'/store/mc/RunIIFall17MiniAOD/WminusH_HToZZTo4L_M125_13TeV_powheg2-minlo-HWJ_JHUGenV7011_pythia8/MINIAODSIM/94X_mc2017_realistic_v10-v1/10000/80B92986-8501-E811-99BB-002590200900.root'#2017 Synchronization
#'file:RunIIFall17MiniAOD_VBF_HToZZTo4L_M125_13TeV_E8505BB6-5F07-E811-B009-002590DE6E88.root'
 ),
skipEvents= cms.untracked.uint32(9000)
)

## # Endpath
#process.o = cms.EndPath ( process.hTozzTo4leptonsSelectionOutputModuleNew )  #reham need to comment in run in crab
