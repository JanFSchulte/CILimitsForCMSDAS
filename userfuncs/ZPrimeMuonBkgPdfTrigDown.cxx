/***************************************************************************** 
 * Project: RooFit                                                           * 
 *                                                                           * 
 * This code was autogenerated by RooClassFactory                            * 
 *****************************************************************************/ 

// Your description goes here... 

#include "Riostream.h" 

#include "ZPrimeMuonBkgPdfTrigDown.h" 
#include "RooAbsReal.h" 
#include "RooAbsCategory.h" 
#include <math.h> 
#include "TMath.h" 

ClassImp(ZPrimeMuonBkgPdfTrigDown) 

 ZPrimeMuonBkgPdfTrigDown::ZPrimeMuonBkgPdfTrigDown(const char *name, const char *title, 
                        RooAbsReal& _mass,
                        RooAbsReal& _bkg_a,
                        RooAbsReal& _bkg_b,
                        RooAbsReal& _bkg_c,
                        RooAbsReal& _bkg_d,
                        RooAbsReal& _bkg_e,
                        RooAbsReal& _bkg_syst_a,
                        RooAbsReal& _bkg_syst_b,
			RooAbsReal& _cat) :
   RooAbsPdf(name,title), 
   mass("mass","mass",this,_mass),
   bkg_a("bkg_a","bkg_a",this,_bkg_a),
   bkg_b(" bkg_b"," bkg_b",this,_bkg_b),
   bkg_c(" bkg_c"," bkg_c",this,_bkg_c),
   bkg_d(" bkg_d"," bkg_d",this,_bkg_d),
   bkg_e(" bkg_e"," bkg_e",this,_bkg_e),
   bkg_syst_a(" bkg_syst_a"," bkg_syst_a",this,_bkg_syst_a),
   bkg_syst_b(" bkg_syst_b"," bkg_syst_b",this,_bkg_syst_b),
   cat("cat","cat",this,_cat)
 { 
 } 


 ZPrimeMuonBkgPdfTrigDown::ZPrimeMuonBkgPdfTrigDown(const ZPrimeMuonBkgPdfTrigDown& other, const char* name) :  
   RooAbsPdf(other,name), 
   mass("mass",this,other.mass),
   bkg_a("bkg_a",this,other.bkg_a),
    bkg_b("bkg_b",this,other.bkg_b),
    bkg_c("bkg_c",this,other.bkg_c),
    bkg_d("bkg_d",this,other.bkg_d),
    bkg_e("bkg_e",this,other.bkg_e),
    bkg_syst_a("bkg_syst_a",this,other.bkg_syst_a),
    bkg_syst_b("bkg_syst_b",this,other.bkg_syst_b),
    cat("cat",this,other.cat)
 { 
 } 



 Double_t ZPrimeMuonBkgPdfTrigDown::evaluate() const 
 { 
   // ENTER EXPRESSION IN TERMS OF VARIABLE ARGUMENTS HERE 
   double val =  exp(bkg_a+mass*bkg_b+mass*mass*bkg_c+mass*mass*mass*bkg_d)*pow(mass,bkg_e)*(bkg_syst_a + bkg_syst_b*mass) ;
   if (cat == 0) return val*1./((0.987826232915 + -7.81615984033e-08*mass)/(0.985548976863+ -2.28261035836e-07*mass)); 
  else if (cat == 1) return val*1./((0.971242305389  + 3.10628148131e-07*mass ) / (0.987369135229 + -3.75634851186e-05*mass + 2.48504956152e-09*mass*mass));
  else return val*1./((0.972352522752 + -3.34032692503e-06*mass + 1.61745590874e-10*mass*mass) / (0.981606029688 + -1.39766860383e-05*mass + -9.42079658943e-09*mass*mass));

 } 