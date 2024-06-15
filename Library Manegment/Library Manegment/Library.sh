registration(){
    echo
    read -p "    Enter the student ID: " id
    read -p "    Enter the student name: " name
    read -p "    Enter the Batch: " batch
    read -p "    Enter the department: " dept
    read -p "    Enter the user name: " user
    read -s -p "    Enter the password: " pass
    echo
    echo "$id    $name        $batch    $dept" >> student.txt
    echo "$id    $name    $batch    $dept    $user    $pass" >> admin.txt
    echo
    echo "    Registration successfully"
}

login(){
    echo
    read -p "    Enter the student ID: " logid
    read -s -p "    Enter the password: " logpass
    echo
    lid=0
    lpass=0

    while read c1 c2 c3 c4 c5 c6
    do
        if [ "$logid" == "$c1" ] && [ "$logpass" == "$c6" ]
        then
            lid=$c1
            lpass=$c6
            echo
            echo "    Login successfully"
        fi
    done < admin.txt

    if [ "$lid" == 0 ]
    then
        echo
        echo "    Incorrect password"
        echo "    Please try again"
    fi
}

display(){
    echo
    cat bookList.txt
}

addbook(){
    echo
    read -p "    Enter the book category: " cata
    read -p "    Enter the author name: " author
    read -p "    Enter the book title: " title
    echo "$cata    $author    $title" >> bookList.txt
    echo
    echo "    Add successfully"
}

search(){
    echo
    read -p "    Enter the title name: " stitle
    s=0
    la=()
    lc=()
    lt=()
    no=0

    while read c1 c2 c3
    do
        if [[ "$stitle" == "$c3" ]]
        then
            lc[$no]=$c1
            la[$no]=$c2
            lt[$no]=$c3
            s=$((s + 1))
            no=$((no + 1))
        fi
    done < bookList.txt

    if [ $s == 0 ]
    then
        echo
        echo "    This book is not found in the library"
    else
        echo
        echo "    This book is found"
        echo "    No. of $s books are available in the library"
        echo
        echo "    Category    AuthorName    Title"
        echo "    --------    -----------    --------"
        p=0
        while [ $p -lt ${#la[@]} ]
        do
            echo "    ${lc[$p]}    ${la[$p]}    ${lt[$p]}"
            p=$((p + 1))
        done
    fi
    echo
}

studentlist(){
    echo
    p=1
    q=4
    while [ $p -lt $q ]
    do
        echo "    Display the student list for: "
        echo "    1. Student side"
        echo "    2. Admin side"
        read -p "    Choose any option: " ch
        if [ $ch == 1 ]
        then
            echo
            cat student.txt
            echo
            break
        elif [ $ch == 2 ]
        then
            echo
            x=1
            y=5
            while [ $x -lt $y ]
            do
                read -s -p "    Enter the admin password: " pa
                echo
                if [ "$pa" == "kausiq" ]
                then
                    echo
                    cat admin.txt
                    echo
                    p=$q
                    break
                else
                    echo
                    echo "    Please try again"
                    x=$((x + 1))
                    if [ $x == 4 ]
                    then
                        break
                    fi
                fi
            done
        else
            echo
            echo "    Please try again"
            p=$((p + 1))
            if [ $p == 4 ]
            then
                break
            fi
        fi
    done
}

removestudent(){
    echo
    read -p "    Do you want to remove (yes/no): " ch
    if [ $ch == yes ]
    then
        read -p "    Enter the deleting id: " did
        read -s -p "    Enter the admin password: " apass
        if [ "$apass" == "kausiq" ]
        then
            sed -i "/$did/d" admin.txt
            sed -i "/$did/d" student.txt
            echo
            echo "    Remove successfully"
        else
            echo
            echo "    Pass invalid"
        fi
    fi
}

takebook(){
    echo
    t=1
    tt=2
    line=0
    count=1
    while [ $t -lt $tt ]
    do
        read -p "    Do you want to purchase a book (yes/no): " per
        if [ $per == yes ]
        then
            read -p "    Enter the book category name: " tcat
            read -p "    Enter the book author name: " tau
            read -p "    Enter the book title name: " tti

            while read x1 x2 x3
            do
                if [ "$x1" == "$tcat" ] && [ "$x2" == "$tau" ] && [ "$x3" == "$tti" ]
                then
                    line=$count
                fi
                count=$((count + 1))
            done < bookList.txt

            if [ $line == 0 ]
            then
                echo
                echo "    This book is not found in the library"
            else
                sed -i "${line}d" "bookList.txt"
                echo
                echo "    Purchase successfully"
            fi
        else
            t=2
        fi
    done
    echo
}

edit(){
    echo
    echo "    This is the password change function."
    echo
    echo "    This is the ID: $1"
    id=$1
    i=0
    cou=1
    read -p "    Do you want to change the password (yes/no): " ch
    if [ $ch == yes ]
    then
        read -p "    Enter the new password: " npass
        read -p "    Enter the old password: " opass

        while read a1 a2 a3 a4 a5 a6
        do
            if [ "$a1" == "$id" ]
            then
                i=$cou
                if [ "$opass" == "$a6" ]
                then
                    sed -i "${i}s/$opass/$npass/" "admin.txt"
                    echo
                    echo "    Password changed successfully"
                fi
            fi
            cou=$((cou + 1))
        done < admin.txt
    fi
}

echo
echo "    -----Welcome to Library Management System-----"
i=1
n=2
while [ $i -lt $n ]
do
    echo
    echo "    Do you want to Register or Login: "
    echo "    1. Registration"
    echo "    2. Login"
    read -p "    Enter your choice: " ch
    if [ $ch == 1 ]
    then
        registration
    elif [ $ch == 2 ]
    then
        login
        if [ "$lid" != 0 ]
        then
            i=$n
        fi
    else
        echo
        echo "    Please choose a correct option"
        echo "    Try again"
    fi
done

j=0
k=2
while [ $j -lt $k ]
do
    echo
    echo "    -------Home Page------"
    echo "    1. Display Book List"
    echo "    2. Add Book"
    echo "    3. Search Book"
    echo "    4. Register Student list"
    echo "    5. Remove Student"
    echo "    6. Take Book"
    echo "    7. Registration"
    echo "    8. Change password"
    echo "    0. Exit"
    echo
    read -p "    Please choose any one: " choose
    if [ $choose == 1 ]
    then
        display
    elif [ $choose == 2 ]
    then
        addbook
    elif [ $choose == 3 ]
    then
        search
    elif [ $choose == 4 ]
    then
        studentlist
    elif [ $choose == 5 ]
    then
        removestudent
    elif [ $choose == 6 ]
    then
        takebook
    elif [ $choose == 7 ]
    then
        registration
    elif [ $choose == 8 ]
    then
        edit $lid
    elif [ $choose == 0 ]
    then
        echo
        echo "    Program completed"
        echo
        break
    else
        echo
        echo "    Choose the correct option"
        echo "    Please try again"
    fi
done

