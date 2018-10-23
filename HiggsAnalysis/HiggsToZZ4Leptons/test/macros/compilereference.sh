#!/bin/bash

exedir=${CMSSW_BASE}/src/HiggsAnalysis/HiggsToZZ4Leptons/test/macros

melalibdir=${CMSSW_BASE}/lib/${SCRAM_ARCH}
melalibdata=${CMSSW_BASE}/src/ZZMatrixElement/MELA/data/${SCRAM_ARCH}
# melaincdir=${CMSSW_BASE}/src
melaincdir=${CMSSW_BASE}/src/ZZMatrixElement/MELA/interface

cmsswlibdir=$CMSSW_RELEASE_BASE/lib/${SCRAM_ARCH}

export LD_LIBRARY_PATH=${melalibdir}:${melalibdata}:$LD_LIBRARY_PATH



if [ "$1" == "" ]; then
    echo "Please provide an arguments to the script: 4e, 4mu, 2e2mu or all"
    exit
fi

if [ $1 == "4mu" ]; then
    echo "Compiling $1 macros"

 #   g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir}  compilereference_4mu_single.C HZZ4LeptonsAnalysis_4mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration -lCondFormatsJetMETObjects -l JetMETCorrectionsModules -o RunReference4mu

 #   g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir}  compilereference_4mu_bkg.C HZZ4LeptonsAnalysis_4mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir}  -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration -lCondFormatsJetMETObjects -l JetMETCorrectionsModules  -o RunReference4mu_bkg

 g++ -DSTANDALONE -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${CMSSW_BASE}/src  -I ${CMSSW_RELEASE_BASE}/src compilereference_4mu_bkg.C HZZ4LeptonsAnalysis_4mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${CMSSW_RELEASE_BASE}/src -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lCondFormatsJetMETObjects -l JetMETCorrectionsModules -o RunReference4mu_bkg

#TRY

#g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${CMSSW_BASE}/src -I ${CMSSW_RELEASE_BASE}/src compilereference_4mu_bkg.C HZZ4LeptonsAnalysis_4mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -o RunReference4mu_bkg

#TRY

   # g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${CMSSW_BASE}/src compilereference_4mu_bkg.C HZZ4LeptonsAnalysis_4mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects -l JetMETCorrectionsModules  -o RunReference4mu_bkg

   # g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir} compilereference_4mu_signal.C HZZ4LeptonsAnalysis_4mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir}  -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration -lCondFormatsJetMETObjects -l JetMETCorrectionsModules  -o RunReference4mu_signal

  #  g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir} compilereference_4mu_data.C HZZ4LeptonsAnalysis_4mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir}  -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration -lCondFormatsJetMETObjects -l JetMETCorrectionsModules  -o RunReference4mu_data

elif [ $1 == "4e" ]; then
    echo "Compiling $1 macros"
 #   g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir}  -I ${cmsswincdir} compilereference_4e_single.C HZZ4LeptonsAnalysis_4e.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules  -o RunReference4e
 
 g++ -DSTANDALONE -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${CMSSW_BASE}/src  -I ${CMSSW_RELEASE_BASE}/src compilereference_4e_bkg.C HZZ4LeptonsAnalysis_4e.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${CMSSW_RELEASE_BASE}/src -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lCondFormatsJetMETObjects -l JetMETCorrectionsModules -o RunReference4e_bkg

  # g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir}  -I ${cmsswincdir} compilereference_4e_bkg.C HZZ4LeptonsAnalysis_4e.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir}  -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference4e_bkg
   
# g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir}  -I ${cmsswincdir} compilereference_4e_signal.C HZZ4LeptonsAnalysis_4e.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir}  -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules  -o RunReference4e_signal
 
#   g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir}  -I ${cmsswincdir} compilereference_4e_data.C HZZ4LeptonsAnalysis_4e.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir}  -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference4e_data

elif [ $1 == "2e2mu" ]; then
    echo "Compiling $1 macros"
  #  g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir}  compilereference_2e2mu_single.C HZZ4LeptonsAnalysis_2e2mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference2e2mu
 
 g++ -DSTANDALONE -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${CMSSW_BASE}/src  -I ${CMSSW_RELEASE_BASE}/src compilereference_2e2mu_bkg.C HZZ4LeptonsAnalysis_2e2mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${CMSSW_RELEASE_BASE}/src -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lCondFormatsJetMETObjects -l JetMETCorrectionsModules -o RunReference2e2mu_bkg

#   g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir}  compilereference_2e2mu_bkg.C HZZ4LeptonsAnalysis_2e2mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference2e2mu_bkg
 
#   g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir}  compilereference_2e2mu_signal.C HZZ4LeptonsAnalysis_2e2mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference2e2mu_signal
 
#   g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir} compilereference_2e2mu_data.C HZZ4LeptonsAnalysis_2e2mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference2e2mu_data

elif [ $1 == "all" ]; then    
    echo "Compiling $1 macros"

  #  g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir}  compilereference_4mu_single.C HZZ4LeptonsAnalysis_4mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference4mu
    g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir}  compilereference_4mu_bkg.C HZZ4LeptonsAnalysis_4mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir}  -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference4mu_bkg
    g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir} compilereference_4mu_signal.C HZZ4LeptonsAnalysis_4mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir}  -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference4mu_signal
    g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir} compilereference_4mu_data.C HZZ4LeptonsAnalysis_4mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir}  -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration -lCondFormatsJetMETObjects -l JetMETCorrectionsModules  -o RunReference4mu_data

  #  g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir}  -I ${cmsswincdir} compilereference_4e_single.C HZZ4LeptonsAnalysis_4e.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects -o RunReference4e
    g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir}  -I ${cmsswincdir} compilereference_4e_bkg.C HZZ4LeptonsAnalysis_4e.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir}  -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference4e_bkg
    g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir}  -I ${cmsswincdir} compilereference_4e_signal.C HZZ4LeptonsAnalysis_4e.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir}  -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration   -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference4e_signal
    g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir}  -I ${cmsswincdir} compilereference_4e_data.C HZZ4LeptonsAnalysis_4e.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir}  -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference4e_data


  #  g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir}  compilereference_2e2mu_single.C HZZ4LeptonsAnalysis_2e2mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference2e2mu
    g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir}  compilereference_2e2mu_bkg.C HZZ4LeptonsAnalysis_2e2mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference2e2mu_bkg
    g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir}  compilereference_2e2mu_signal.C HZZ4LeptonsAnalysis_2e2mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference2e2mu_signal
    g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir} compilereference_2e2mu_data.C HZZ4LeptonsAnalysis_2e2mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference2e2mu_data


  #  g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir} compilereference_4e_foreachfile.C HZZ4LeptonsAnalysis_4e.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference4e_foreachfile
  #  g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir} compilereference_4mu_foreachfile.C HZZ4LeptonsAnalysis_4mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference4mu_foreachfile
  #  g++ -I $ROOTSYS/include -I $ROOFITSYS/include -I ${melaincdir} -I ${cmsswincdir} compilereference_2e2mu_foreachfile.C HZZ4LeptonsAnalysis_2e2mu.C `root-config --glibs` `root-config --libs` `root-config --cflags` -L $ROOFITSYS/lib  -lRooFit -lRooFitCore -L ${melalibdir} -L ${cmsswlibdir} -lZZMatrixElementMELA   -lZZMatrixElementMEMCalculators -lKaMuCaCalibration  -lCondFormatsJetMETObjects  -l JetMETCorrectionsModules -o RunReference2e2mu_foreachfile

fi
