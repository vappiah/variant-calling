


ref=data/ref/hg19.chr5_12_17.fa 
threads=8

mkdir BAMS
for sample in normal tumor
do
if [ $sample == "normal" ]
then 
RGID="231335"
RGSN="Normal"

elif [ "$sample" == "tumor" ]
then 
RGID="231336"
RGSN="Tumor"
fi


echo $RGID
echo $RGSN
read1=data/fastq/trimmed_reads/${sample}_trimmed_paired_r1.fastq.gz
read2=data/fastq/trimmed_reads/${sample}_trimmed_paired_r2.fastq.gz

#bwa mem -t $threads -R "@RG\\tID:${RGID}\\tPL:Illumina\\tPU:None\\tLB:None\\tSM:${RGSN}" $ref $read1 $read2 | samtools view -Shb-q 1 -F 0x4 -f 0x2 -o BAMS/${sample}.raw.bam

bwa mem -t $threads -R "@RG\\tID:${RGID}\\tPL:Illumina\\tPU:None\\tLB:None\\tSM:${RGSN}" $ref $read1 $read2 | samtools view -h -b -o BAMS/${sample}.raw.bam


bamtools filter -in BAMS/${sample}.raw.bam -mapQuality ">=1" -isMapped true -isMateMapped true -out BAMS/${sample}.filtered.bam

echo "sorting by name"
samtools sort -@ $threads -n BAMS/${sample}.filtered.bam -o BAMS/${sample}.sorted.n.bam 

echo "applying fixmate"
samtools fixmate -m BAMS/${sample}.sorted.n.bam BAMS/${sample}.fixmate.bam

echo "sorting by coordinate"
samtools sort -@ $threads BAMS/${sample}.fixmate.bam -o BAMS/${sample}.sorted.p.bam 

echo "marking and removing duplicates"
samtools markdup -r -@ $threads BAMS/${sample}.sorted.p.bam BAMS/${sample}.dedup.bam 

echo "duplicates have been removed"

done



#bamtools filter -in BAMS/normal.calmd.bam -mapQuality ">=1" isMapped true isMateMapped true -out BAMS/normal.final.bam

#sMapped
#isMateMapped




