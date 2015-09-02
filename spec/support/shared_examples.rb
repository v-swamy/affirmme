shared_examples "requires sign in" do
  it "redirects to the sign in page" do
    session[:user_id] = nil
    action
    expect(response).to redirect_to root_path
  end

  it "sets the flash danger message" do
    session[:user_id] = nil
    action
    expect(flash[:danger]).to be_present
  end
end

shared_examples "access denied" do
  it "redirects to home page if signed in user accesses page for a different user" do
    set_current_user if session[:user_id] == nil
    action
    expect(response).to redirect_to root_path
  end

  it "sets the flash danger message" do
    set_current_user if session[:user_id] == nil
    action
    expect(flash[:danger]).to be_present
  end
end