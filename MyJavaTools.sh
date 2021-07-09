banner() {
 echo " __  __             _                    _____           _        "
 echo "|  \/  |_   _      | | __ ___   ____ _  |_   _|__   ___ | |___    "
 echo "| |\/| | | | |  _  | |/ _' \ \ / / _' |   | |/ _ \ / _ \| / __|   "
 echo "| |  | | |_| | | |_| | (_| |\ V / (_| |   | | (_) | (_) | \__ \   "
 echo "|_|  |_|\__, |  \___/ \__,_| \_/ \__,_|   |_|\___/ \___/|_|___/   "
 echo "        |___/                                                     "
 echo "=============================================================== "
 echo -e "                                               Coded By: Zavier \n"
}

pause() {
 read -s -n 1 -p "Press any key to continue . . ."
}

load() {
 clear
 banner
 echo "Menu : "
 echo "[1] Compile Java File"
 echo "[2] Make Dex File"
 echo "[3] Delete All Class Files"
 echo "[4] Run Java Program"
 echo "[#] Exit"
 echo "========================="
 echo -n "-> "
 read Menu
       
 if [ $Menu = "1" ]; then
        clear
        banner
        java_files=$(ls *.java)
        echo -e "Current directory: $(pwd)\n"
        echo -e "List *.java files in directory : "
        for index in ${!java_files[@]}; do
              echo " [${index+1}] ${java_files[$index]}"
        done

        echo
        echo -n "Filename '.java' : ";
        read Filename

        directory_location=$(pwd)

        ecj "$directory_location/$Filename"
        pause
        load
 elif [ $Menu = "2" ]; then
        clear
        banner
        class_files=$(ls *.class)
        if [[ "No such file or directory" == *"$class_files"* ]]; then
              echo -e "Please compile java file frist !\n"
              pause
              load
        fi

        echo -e "Current directory: $(pwd)\n"
        echo -e "List *.class files in directory : "
        for index in ${!class_files[@]}; do
              echo " [${index+1}] ${class_files[$index]}"
        done

        echo -e "\nThis process will make output .jar and .dex files";
        echo -e "Note: dex file and main class name should same\n"
        echo -n "Main Class Name : "
        read Filename

        zip "$Filename.jar" *.class
        dx --dex --output "$Filename.dex" "$Filename.jar"
        pause
        load
 elif [ $Menu = "3" ]; then
        clear
        banner
        file_location="$(pwd)/*.class"
        rm $file_location
        pause
        load
 elif [ $Menu = "4" ]; then
        clear 
        banner
        dex_files=$(ls *.dex)
        if [[ "No such file or directory" == *"$dex_files"* ]]; then
              echo -e "Please create dex file frist !\n"
              pause
              load
        fi

        echo -e "Current directory: $(pwd)\n"
        echo -e "List *.dex files in directory : "
        for index in ${!dex_files[@]}; do
              echo " [${index+1}] ${dex_files[$index]}"
        done
        
        echo -e "\nNote: dex file and main class name should same\n"
        echo -n "Dex File : "
        read Filename

	clear
        dalvikvm -cp "$Filename.dex" "$Filename"
 elif [ $Menu = "#" ]; then
        exit
 else
        echo -e "\nSorry, system doesn't reconigze your input";
        pause
        load
 fi
}

load
