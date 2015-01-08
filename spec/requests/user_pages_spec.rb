require 'spec_helper'

describe "UserPages" do

  subject{page}
  
  describe "signup page" do
     
     before{visit signup_path}
     
     it{should have_selector('h1',text: 'Sign Up')}
     it{should have_selector('title',text: full_title('Sign Up'))}
  end
  
  describe "profile page" do
    let(:user){FactoryGirl.create(:user)}
     before{visit user_path(user)}
     it{should have_selector('h1',text: user.name)}
     it{should have_selector('title',text: user.name)}
  end
  
  describe "signup" do
     before{visit signup_path}
     let(:submit){"Create my account"}
     
     describe "Empty signup form"do
        it "should not create user" do
           expect{click_button submit}.not_to change(User, :count)
        end
     end
     
     describe "valid signup form" do
        before do
           fill_in "Name", with: "Vaibhav Gupta"
           fill_in "Email", with: "vaibhav.gupta.cse11@iitbhu.ac.in"
           fill_in "Password", with: "foobar"
           fill_in "Password confirmation", with: "foobar" 
        end
        
        it "should create user" do
           expect do
              click_button submit
           end.to change(User, :count).by(1)
        end
        
        describe "after saving the user" do
           before { click_button submit }
           let(:user) { User.find_by_email("vaibhav.gupta.cse11@iitbhu.ac.in") }
           it { should have_selector('title', text: user.name) }
           it { should have_selector('div.alert.alert-success', text: 'Welcome') }
        end
     end
     
     describe "invalid user information" do
        before do
           fill_in "Name", with: "Vaibhav Gupta"
           fill_in "Email", with: "vaibhav.gupta.cse11@iitbhu.ac.in"
           fill_in "Password", with: "foobar"
           fill_in "Password confirmation", with: "foo" 
        end
        
        describe "after submission" do
          before { click_button submit }
          it { should have_selector('title', text: 'Sign Up') }
          it { should have_content('error') }
        end
     end
     
  end
end
