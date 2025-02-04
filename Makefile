
uniongazetteer/link_settings.pickle : data_matching_training.json input.csv
	unionlookup -vv -t $^

uniongazetteer/data/opdr_local.csv : opdr_local_0.csv opdr_local_1.csv opdr_local_2.csv opdr_local_3.csv opdr_local_4.csv opdr_local_5.csv opdr_local_6.csv
	csvstack $^ > $@

opdr_local_%.csv :
	wget -O $@ "https://labordata.bunkum.us/opdr-8335ea3.csv?sql=with+most_recent_lu+as+(%0D%0A++select%0D%0A++++*%0D%0A++from%0D%0A++++(%0D%0A++++++select%0D%0A++++++++*%0D%0A++++++from%0D%0A++++++++lm_data%0D%0A++++++order+by%0D%0A++++++++f_num%2C%0D%0A++++++++receive_date+desc%0D%0A++++)+t%0D%0A++group+by%0D%0A++++f_num%0D%0A)%0D%0Aselect%0D%0A++aff_abbr+%7C%7C+coalesce(%27+local+%27+%7C%7C+coalesce(desiq_pre+%7C%7C+%27-%27%2C+%27%27)+%7C%7C+desig_num+%7C%7C+coalesce(%27-%27+%7C%7C+desig_suf%2C+%27%27)%2C+%27+%27+%7C%7C+unit_name)+as+abbr_local_name%2C%0D%0A++coalesce(%0D%0A++++regexp_match(%27(.*%3F)(%2C%3F+AFL-CIO%24)%27%2C+union_name)%2C%0D%0A++++regexp_match(%27(.*%3F)(+IND%24)%27%2C+union_name)%2C%0D%0A++++union_name%0D%0A++)+%7C%7C+coalesce(%27+local+%27+%7C%7C+coalesce(desiq_pre+%7C%7C+%27-%27%2C+%27%27)+%7C%7C+desig_num+%7C%7C+coalesce(%27-%27+%7C%7C+desig_suf%2C+%27%27)%2C+%27+%27+%7C%7C+unit_name)+as+full_local_name%2C%0D%0A++*%0D%0Afrom%0D%0A++most_recent_lu%0D%0Awhere+(desig_num+IS+NOT+NULL+OR+unit_name+IS+NOT+NULL)+AND+desig_name+!%3D+%27NHQ%27%0D%0Alimit%0D%0A++5000+offset+$(OFFSET)&_size=max"

opdr_local_0.csv : OFFSET=0

opdr_local_1.csv : OFFSET=5001

opdr_local_2.csv : OFFSET=10001

opdr_local_3.csv : OFFSET=15001

opdr_local_4.csv : OFFSET=20001

opdr_local_5.csv : OFFSET=25001

opdr_local_6.csv : OFFSET=30001
