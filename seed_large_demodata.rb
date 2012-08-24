# Seed some large demo dataset into localhost recline database

require 'sequel'
require 'faker'

DB = Sequel.connect(
    :adapter => 'mysql2',
    :host => 'localhost',
    :user => 'root',
    :password => '',
    :database => 'recline',
    :timeout => 30,
    :reconnect => true
)

DB.create_table! :items do
  primary_key :id
  Integer :x
  Integer :y
  Integer :z
  String :country
  String :title
  BigDecimal :lat, :size=>[9, 5]
  BigDecimal :lon, :size=>[9, 5]
end

countries = %w{AF AX AL DZ AS AD AO AI AQ AG AR AM AW AU AT AZ BS BH BD BB BY BE BZ BJ BM BT BO BQ BA BW BV BR IO BN BG BF BI KH CM CA CV KY CF TD CL CN CX CC CO KM CG CD CK CR CI HR CU CW CY CZ DK DJ DM DO EC EG SV GQ ER EE ET FK FO FJ FI FR GF PF TF GA GM GE DE GH GI GR GL GD GP GU GT GG GN GW GY HT HM VA HN HK HU IS IN ID IR IQ IE IM IL IT JM JP JE JO KZ KE KI KP KR KW KG LA LV LB LS LR LY LI LT LU MO MK MG MW MY MV ML MT MH MQ MR MU YT MX FM MD MC MN ME MS MA MZ MM NA NR NP NL NC NZ NI NE NG NU NF MP NO OM PK PW PS PA PG PY PE PH PN PL PT PR QA RE RO RU RW BL SH KN LC MF PM VC WS SM ST SA SN RS SC SL SG SX SK SI SB SO ZA GS SS ES LK SD SR SJ SZ SE CH SY TW TJ TZ TH TL TG TK TO TT TN TR TM TC TV UG UA AE GB US UM UY UZ VU VE VN VG VI WF EH YE ZM ZW}

def range (min, max)
  rand * (max-min) + min
end

(1..10000).each do |i|
  DB[:items].insert :x => i,
    :y => i*2,
    :z => rand(1000),
    :country => countries[rand(countries.size)],
    :title => Faker::Name.name,
    :lat => range(-90, 90),
    :lon => range(180, -180)
end