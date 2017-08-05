FactoryGirl.define do
    factory :announcement do
        title 'Rspec'
        content 'testing'
        committee_id '297062136'
    end

    factory :category do
        name 'Board Overview'
    end
end