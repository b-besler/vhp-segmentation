#Bash script to get VHP Female data

SAVE_DIR='RAW'
mkdir $SAVE_DIR
#Download files from index file
download_file() {
    VHP_URL="$1$2"
    echo "$VHP_URL"
    wget $VHP_URL -P $SAVE_DIR
    uncompress "$SAVE_DIR/$2"
    rm "$SAVE_DIR/$2"
}

wget -O index.txt https://data.lhncbc.nlm.nih.gov/public/Visible-Human/Female-Images/INDEX
URL='https://data.lhncbc.nlm.nih.gov/public/Visible-Human/Female-Images/radiological/mri/'
#MRI Data Starts on Line 12350 and ends of Line 13334
echo 'Delete Lines'
sed -i '13335,$d' index.txt
sed -i '1,12349d' index.txt
awk '{print $9}' index.txt > mri_index.txt

while read p; do
    echo $p
    download_file $URL $p
done <mri_index.txt

mkdir $SAVE_DIR/t1
mv $SAVE_DIR/*.t1 $SAVE_DIR/t1
mkdir $SAVE_DIR/t2
mv $SAVE_DIR/*.t2 $SAVE_DIR/t2
mkdir $SAVE_DIR/pd
mv $SAVE_DIR/*.pd $SAVE_DIR/pd
mkdir $SAVE_DIR/loc
mv $SAVE_DIR/*.loc $SAVE_DIR/loc/*.dcm
