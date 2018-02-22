set LABEL_1=V05_05_212
set LABEL_2=V05_05_213
set BRANCH_NAME=v05_05_server_sust_off_main_br
echo "ama"

cleartool find -avobs -version "brtype(%BRANCH_NAME%) && lbtype(%LABEL_2%) && !lbtype(%LABEL_1%)" ^
-exec "cleartool describe  -fmt \"CR NUMBER: %NS[CR_NUM]a\nELEMENT:   %En\nVERSION:    %Xn\n\n\n\"  %CLEARCASE_XPN% "
