# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

scott = User.new( first_name: "Scott",
                  last_name: "Gerlach",
                  birthday: "1979-06-26 17:00:00",
                  email: "swgerlach@gmail.com",
                  password: "password",
                  password_confirmation: "password",
                  terms_of_service: true,
                )
scott.skip_confirmation!
scott.admin = true
scott.save!(validate: false)

cheyenne = User.new( first_name: "Cheyenne",
                  last_name: "Weaver",
                  birthday: "1979-09-22 17:00:00",
                  email: "cheyenneweaver@gmail.com",
                  password: "password",
                  password_confirmation: "password",
                  terms_of_service: true,
                )
cheyenne.skip_confirmation!
cheyenne.admin = true
cheyenne.save!(validate: false)

diana = User.new( first_name: "Diana",
                  last_name: "Griffin",
                  birthday: "1982-03-07 17:00:00",
                  email: "dianadgriffin@gmail.com",
                  password: "password",
                  password_confirmation: "password",
                  terms_of_service: true,
                )
diana.skip_confirmation!
diana.admin = true
diana.save!(validate: false)

artist = User.new( first_name: "Jane",
                  last_name: "Smith",
                  birthday: "1980-08-08 17:00:00",
                  email: "artist@girlsguild.com",
                  password: "password",
                  password_confirmation: "password",
                  terms_of_service: true,
                )
artist.skip_confirmation!
artist.save!(validate: false)

girl = User.new( first_name: "Tina",
                  last_name: "Jones",
                  birthday: "1997-01-01 17:00:00",
                  email: "girl@girlsguild.com",
                  password: "password",
                  password_confirmation: "password",
                  terms_of_service: true,
                )
girl.skip_confirmation!
girl.save!(validate: false)

first_workshop = artist.workshops.create!(  "host_firstname"=>"Jane",
                                            "host_lastname"=>"Smith",
                                            "host_business"=>"JS Designs",
                                            "bio"=>"Vivamus ut accumsan nulla. Maecenas consequat vestibulum dapibus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla at purus urna. Sed adipiscing risus non elit molestie eget tempus massa porta. Ut in ligula elit. ",
                                            "website"=>"jsdesigns.com",
                                            "webshop"=>"shop.jsdesigns.com",
                                            "facebook"=>"janesmith",
                                            "twitter"=>"janesmith",
                                            "topic"=>"Sculpture with Paper",
                                            "description"=>" Nam hendrerit eleifend tristique. Donec sed odio orci. Phasellus eu nibh eros, ut malesuada dui. Vestibulum ac convallis ante. Aliquam placerat aliquet mauris ac pellentesque. Suspendisse non turpis in erat fermentum sollicitudin sed ac lectus. Ut vitae bibendum quam. Pellentesque at dui sem. Ut vitae risus leo, at commodo risus. Nulla interdum molestie imperdiet. Nam ut gravida leo. Nunc sit amet nisl nibh, quis mattis mi. Fusce et pharetra mi. Mauris magna lectus, posuere in aliquam nec, sodales eget enim. Lorem ipsum dolor sit amet, consectetur adipiscing elit. ",
                                            "skill_list"=>"'sketching','critical analysis'",
                                            "tool_list"=>"'paper','exacto blades','adhesives'",
                                            "requirement_list"=>"",
                                            "other_needs"=>"Wear clothes that can get dirty or an apron",
                                            "age_min"=>"13", "age_max"=>"45",
                                            "registration_min"=>"2",
                                            "registration_max"=>"8",
                                            "begins_at"=>"01/01/2014",
                                            "begins_at_time"=>"10:15 AM",
                                            "ends_at_time"=>"12:15 PM",
                                            "datetime_tba"=>"1",
                                            "location_address"=>"1309 Chestnut Ave.",
                                            "location_address2"=>"",
                                            "location_city"=>"Austin",
                                            "location_state"=>"TX",
                                            "location_zipcode"=>"78702",
                                            "location_private"=>"0",
                                            "location_nbrhood"=>"Chestnut",
                                            "price"=>"65",
                                            "ends_at"=>"12/01/2013",
                                            "payment_options"=>"Paypal",
                                            "paypal_email"=>"artist@girlsguild.com",
                                            "sendcheck_address"=>"",
                                            "sendcheck_address2"=>"",
                                            "sendcheck_city"=>"",
                                            "sendcheck_state"=>"",
                                            "sendcheck_zip"=>"",
                                            "respect_my_style"=>"0",
                                            "permission"=>"1"
                                          )

first_apprenticeship = artist.apprenticeships.create!(  "host_firstname"=>"Jane",
                                                        "host_lastname"=>"Smith",
                                                        "host_business"=>"JS Designs",
                                                        "bio"=>"Vivamus ut accumsan nulla. Maecenas consequat vestibulum dapibus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nulla at purus urna. Sed adipiscing risus non elit molestie eget tempus massa porta. Ut in ligula elit. ",
                                                        "website"=>"jsdesigns.com",
                                                        "webshop"=>"shop.jedesigns.com",
                                                        "facebook"=>"janesmith",
                                                        "twitter"=>"jane_smith",
                                                        "topic"=>"Sculpture Creation",
                                                        "kind"=>"Production Apprenticeship",
                                                        "description"=>"Quisque in ligula id arcu fringilla gravida a vel purus. Etiam tempus hendrerit augue, vel luctus metus egestas quis. Morbi sit amet felis non purus rutrum adipiscing. Proin aliquet sapien at tellus hendrerit eget cursus orci cursus. Donec turpis sem, ullamcorper eget sodales non, vulputate nec dolor. Proin tortor metus, fringilla eget tristique eu, gravida nec mi. Quisque vitae quam magna, hendrerit sollicitudin metus. Nulla quis purus justo, eget porttitor turpis. Donec fringilla ullamcorper risus vitae lobortis. Sed vitae lacus neque, adipiscing eleifend nisl. Phasellus faucibus erat eget justo luctus consectetur. Curabitur sed venenatis nisi. Suspendisse potenti. ",
                                                        "skill_list"=>"'Paper Sculpting','Sketching','circular sander'",
                                                        "tool_list"=>"'Adhesive','exacto blades','sand paper'",
                                                        "requirement_list"=>"'some comfort with electric tools and blades'",
                                                        "other_needs"=>"Have their own transportation",
                                                        "age_min"=>"16",
                                                        "age_max"=>"25",
                                                        "registration_min"=>"1",
                                                        "registration_max"=>"2",
                                                        "begins_at"=>"06/01/2013",
                                                        "ends_at"=>"12/01/2013",
                                                        "datetime_tba"=>"0",
                                                        "hours"=>"4",
                                                        "hours_per"=>"week",
                                                        "location_address"=>"615 W Johanna St",
                                                        "location_address2"=>"",
                                                        "location_city"=>"Austin",
                                                        "location_state"=>"TX",
                                                        "location_zipcode"=>"78704",
                                                        "location_private"=>"1",
                                                        "location_nbrhood"=>"Bouldin Creek",
                                                        "location_varies"=>"0",
                                                        "respect_my_style"=>"1",
                                                        "stripe_card_token"=>"",
                                                        "permission"=>"1"
                                                     )

