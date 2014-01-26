function [] = sendFailureNotice(errorMsg)
% A simple function to send an email notice when a failure is generated

%% Send error email
% Declare localized infrastructure and email as variables
mySMTP = 'node01';
senderEmail = 'hpc@firmusgrp.com';
receiverEmail = 'mtompkins@firmusgrp.com';

% Set MATLAB prefs
setpref('Internet','SMTP_Server',mySMTP);
setpref('Internet','E_mail',senderEmail);

% Set a subject and send email
subj = 'ALERT - Notice of MATLAB error';
sendmail(receiverEmail,subj,errorMsg);

end

