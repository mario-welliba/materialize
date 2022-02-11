# Start generating orders
#while [[ true ]] ; do

    # Generate orders for all users
    for user_id in {1..1 ; do
        user_id=$(seq 1 100 | sort -R | head -n1)
        score_id=$(seq 1 2 | sort -R | head -n1)
        score=$(seq 70 130 | sort -R | head -n1)        
        export PGPASSWORD='postgres'; psql -h 'localhost' -U 'postgres' -d 'scores' -c "INSERT INTO score_store (user_id, score_id, score) VALUES ( ${user_id}, ${score_id}, ${score} );"
        sleep 0.01
    done

#done