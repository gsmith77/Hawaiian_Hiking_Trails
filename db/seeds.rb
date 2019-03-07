grant = User.create(email: "grantwsmith@gmail.com", password_digest: "123456")
puu_pia = Trail.create(name:"puu pia", length:"1.5 miles", duration:"30 minutes", location:"West Oahu", difficulty:"intermediate", user_id: grant.id)
