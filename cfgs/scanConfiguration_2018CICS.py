leptons = "elmu"
systematics = ['res','massScale',"zPeak","trig","jets","xSecOther","pdf","stats","PU"]
#systematics = ["lumi",'res','massScale',"zPeak","trig","jets","xSecOther","pdf","ID","stats","PU"]
#systematics = []
backgrounds = ['DY','Other','Jets']

correlate = True

lambdas = [10,16,22,28,34,40,46]
interferences = ["ConLL","ConLR","ConRL","ConRR","DesLL","DesLR","DesRL","DesRR"]
#interferences = ["ConLL","ConLR","ConRR"]

binning = [400,500,700,1100,1900,3500,10000]

libraries = []

channels = ["cspos_dielectron_2018_BB","cspos_dielectron_2018_BE","cspos_dimuon_2018_BB","cspos_dimuon_2018_BE","csneg_dielectron_2018_BB","csneg_dielectron_2018_BE","csneg_dimuon_2018_BB","csneg_dimuon_2018_BE"]
numInt = 100000
numToys = 6
exptToys = 500
submitTo = "FNAL"
LPCUsername = "jschulte"
		
