# create job.yaml files
for i in $(eval echo {1..$1})
do
  cat pi-job-template.yml | sed "s/\$ITEM/$i/" > ./job_specs/pi-job-$i.yml
done

