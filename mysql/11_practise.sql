1. Finding 5 oldest users
select * from users order by created_at limit 5;

2. which day users registered most
select count(*) as total,dayname(created_at) as weekday from users group by weekday order by total desc limit 1;
3. FIND USERS who have never posted a photo
mysql> select username from users left join photos on users.id = photos.user_id where photos.image_url is null;
mysql> select username from photos right join  users on users.id = photos.user_id where photos.image_url is null;

4. find whos photo has more likes
mysql> select count(*) as total,photo_id,users.username,photos.image_url from photos inner join likes on photos.id = likes.photo_id inner join users on users.id = photos.user_id group by photo_id order by total desc limit 1;

5. Find most populat hash tags
 select count(*) as photo_tags,tags.tag_name from photo_tags join tags on tags.id = photo_tags.tag_id group by tags.id order by photo_tags desc limit 5;

6. Find users who likes every single photo
select count(*) as total,users.id,users.username as total from users inner join likes on users.id = likes.user_id group by users.id having total = (select count(*) from photos);
