
%% This script will reproduce the full DCM results in the Ince et al., paper.

% Please ensure that your SPM12 folder (r7771) is listed in your MATLAB set
% path. These results were obtained using Matlab R2023a.

%%--------------------------------------------------------------------------------

% The first section runs a PEB model containing parameters to quantify
% shared modulatory effects and the effect of diagnostic status (clinicals versus
% healthy controls), age, and sex on modulatory {'B'} pathways. Data for participant diagnostic status 
% sex and age are stored in M_BMR_group_sex_age.mat.


%load GCM and BMA.mat file 
clear
load('Full_GCM_BMA_Subcortical_Mod_eSN.mat');
load(['M_BMR_group_sex_age.mat']);% This design matrix contains a constant,
                             % data on mean-centred participant diagnostic status (clinical
                             % versus healthy control), sex and age.

[PEB,P]=spm_dcm_peb(DCM, M, { 'B'});
[BMA,BMR] = spm_dcm_peb_bmc(PEB);

%Review the MODULATORY paremeters from the PEB model 
spm_dcm_peb_review (BMA,DCM); 

% (1) To review shared effects (Figure 2, Table S7)
    %--> second-level effect - Mean 
    % -->threshold - very strong evidence (Pp>.99)
    % -->display as matrix(B), input Negative

% (2) To review between-group effects (Figure 3A, Table S8)
    % -->second-level effect - Group 
    % -->threshold - strong evidence (Pp>.99)
    % -->display as matrix(B), input Negative

%%---------------------------------------------------------------------------------------------------

% The second section runs leave-one-out cross validation (LOOCV) to predict, individual diagnostic status, 
% total DASS scores, DASS depression, stress and anxiety scores, 
% using the PAG-aINS connectivity. Please run each LOOCV seperately. 

% %(1) Diagnostic Status (Figure 4A)
load('M_BMR_group_sex_age.mat');
[qE,qC,Q] = spm_dcm_loo(DCM,M,{'B(3,1,2)'}); 

%(2)Total (SQRT) DASS Scores(Figure 4B)
load('M_BMR_SQRT_DASS_total_sex_age.mat'); %contains mean-centred SQRT transformed total DASS scores, sex and age.
[qE,qC,Q] = spm_dcm_loo(DCM,M,{'B(3,1,2)'}); 

%(3)(SQRT) DASS Depression Scores(Figure 4C)
load('M_BMR_SQRT_DASS_depression_sex_age.mat');%contains mean-centred SQRT transformed DASS depression scores, sex and age.
[qE,qC,Q] = spm_dcm_loo(DCM,M,{'B(3,1,2)'}); 

%(4)(SQRT) DASS Stress Scores(Figure 4D)
load('M_BMR_SQRT_DASS_stress_sex_age.mat');%contains mean-centred SQRT transformed DASS stress scores, sex and age.
[qE,qC,Q] = spm_dcm_loo(DCM,M,{'B(3,1,2)'}); 

%(5)(SQRT) DASS Anxiety Scores(Figure S2)
load('M_BMR_SQRT_DASS_anxiety_sex_age.mat');%contains mean-centred SQRT transformed DASS anxiety scores, sex and age.
[qE,qC,Q] = spm_dcm_loo(DCM,M,{'B(3,1,2)'}); 

%Note. To run the same analysis with standardized mean-centred DASS scores,
%change M_BMR_SQRT_....mat to M_BMR_Z_....mat. 
%Eg., 
% load('M_BMR_Z_DASS_total_sex_age.mat');
%[qE,qC,Q] = spm_dcm_loo(DCM,M,{'B(3,1,2)'}); 


%-------------------------------------------------------------------------------------------------------------------------

% The third section runs leave-one-out cross validation (LOOCV) to predict, individual diagnostic status, 
% total DASS scores, DASS depression, stress and anxiety scores, 
% using the AMY-PAG connectivity. Please run each LOOCV seperately. 

% %(1) Diagnostic Status (Table S10)
load('M_BMR_group_sex_age.mat');
[qE,qC,Q] = spm_dcm_loo(DCM,M,{'B(1,2,2)'}); 

%(2)Total (SQRT) DASS Scores (Table S10)
load('M_BMR_SQRT_DASS_total_sex_age.mat'); %contains mean-centred SQRT transformed total DASS scores, sex and age.
[qE,qC,Q] = spm_dcm_loo(DCM,M,{'B(1,2,2)'}); 

%(3)(SQRT) DASS Depression Scores (Table S10)
load('M_BMR_SQRT_DASS_depression_sex_age.mat');%contains mean-centred SQRT transformed DASS depression scores, sex and age.
[qE,qC,Q] = spm_dcm_loo(DCM,M,{'B(1,2,2)'}); 

%(4)(SQRT) DASS Anxiety Scores (Table S10)
load('M_BMR_SQRT_DASS_anxiety_sex_age.mat');%contains mean-centred SQRT transformed DASS anxiety scores, sex and age.
[qE,qC,Q] = spm_dcm_loo(DCM,M,{'B(1,2,2)'}); 

%(5)(SQRT) DASS Stress Scores (Table S10)
load('M_BMR_SQRT_DASS_stress_sex_age.mat');%contains mean-centred SQRT transformed DASS stress scores, sex and age.
[qE,qC,Q] = spm_dcm_loo(DCM,M,{'B(1,2,2)'}); 



