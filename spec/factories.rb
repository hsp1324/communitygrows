FactoryGirl.define do
    factory :announcement do
        title 'Rspec'
        content 'testing'
        committee_type 'internal'
    end
    
    factory :category do
        name 'Board Overview'
    end
end