Given /the following voices exist/ do |voices_table|
    voices_table.hashes.each do |v|
      Voice.create! v
    end
  end