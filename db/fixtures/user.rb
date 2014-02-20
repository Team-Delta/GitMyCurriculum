# This is to seed the data for the database on the local dev machines
# If you want your data to show up in test cases, write a factory in spec/factory

User.seed do |s|
    s.id = 1
    s.username = 'bammons123'
    s.email = 'baileyammons@someplace.com'
    s.name = 'Bailey Ammons'
    s.password = '1234'
end

User.seed do |s|
    s.id = 2
    s.username = 'jfk21'
    s.email = 'jfk@shot.com'
    s.name = 'John Kennedy'
    s.password = 'timer2134'
end

User.seed do |s|
    s.id = 3
    s.username = 'lds21'
    s.email = 'lds@lds.com'
    s.name = 'Lyonal Diamond Saint'
    s.password = 'lkasjdl2398'
end

User.seed do |s|
    s.id = 4
    s.username = 'lakjsd23'
    s.email = 'lijelaij@liajldj.com'
    s.name = 'Jon Patterson'
    s.password = 'lkj20923ljkawd'
end

User.seed do |s|
    s.id = 5
    s.username = 'iouy32973z237'
    s.email = 'lleifj29@oi3u490.com'
    s.name = 'John Thomas'
    s.password = 'l03174912847kjhf'
end

User.seed do |s|
    s.id = 6
    s.username = 'guest'
    s.email = 'g@y.com'
    s.name = 'Guest'
    s.password = 'manjaro1'
end
