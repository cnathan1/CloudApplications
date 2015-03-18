type file;

app (file out) count_wikitengb (file input, file wikitengbcount_script)
{
  bash @wikitengbcount_script @input stdout=@out;
}

app (file out) merge (file s[], file merge_script)
{
  bash @merge_script @s stdout=@out;
}


file wikitengbcount_script <"wikitengbcount.sh">;
file merge_script <"merge.sh">;
file files[]  <filesys_mapper; location="input_chunk", prefix="chunk-">;
file wc_inter[];
file wc_inter1[];



foreach chunks,i in files
{
  file wc_out <single_file_mapper; file=strcat("output/sim_",i,".out")>;
  (wc_out) = count_wikitengb (chunks, wikitengbcount_script);
   wc_inter[i] = wc_out;
 
}
file merge_out <single_file_mapper; file=strcat("output/wordcount-swift.out")>;
merge_out = merge(wc_inter, merge_script);
