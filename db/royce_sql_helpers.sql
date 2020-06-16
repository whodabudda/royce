

#select all the pictures that have been disconnected from their images.
SELECT `pictures`.* 
FROM `pictures` 
WHERE (id not in (select record_id 
					from active_storage_attachments 
                    where name = 'image' and record_type = 'Picture'))
                    
                    