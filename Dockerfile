FROM brodriguesco/r_4.2.2:main-b1950d55ccbd8009de4ee2006a097c3e7ef1c529

RUN mkdir /home/housing

RUN mkdir /home/housing/pipeline_output

RUN mkdir /home/housing/shared_folder

COPY /github/workspace/renv.lock /home/housing/renv.lock

COPY /github/workspace/functions /home/housing/functions

COPY /github/workspace/analyse_data.Rmd /home/housing/analyse_data.Rmd

COPY /github/workspace/_targets.R /home/housing/_targets.R

RUN R -e "setwd('/home/housing');renv::init();renv::restore()"

RUN cd /home/housing && R -e "targets::tar_make()"

CMD mv /home/housing/pipeline_output/* /home/housing/shared_folder/
