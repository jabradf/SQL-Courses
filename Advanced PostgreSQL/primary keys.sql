ALTER TABLE speakers
ADD PRIMARY KEY (id); 

-- caught by the constraints!
/*insert into speakers(email, name, organization, title, years_in_role)
values('J.Saunders@ABCTech.com', 'Joan Saunders', 'ABC Tech.', 'Sr. Data Scientist', 6);*/

-- akready exists!
insert into speakers(id, email, name, organization, title, years_in_role)
values(1, 'J.Saunders@ABCTech.com', 'Joan Saunders', 'ABC Tech.', 'Sr. Data Scientist', 6);