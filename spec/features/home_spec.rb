feature 'Home page' do
  around_with_envs(MASTER_NAMES: 'master1,master2,master3')

  let(:master1) { create(:master, name: 'master1') }
  let(:trainee1) { create(:user) }

  before do
    make_remotty_client_mock_for_any_user
  end

  context 'master としてログイン' do
    before do
      trainee1.start_rally!
    end

    scenario 'ユーザーリストが見える' do
      signin_as master1

      expect(page).to have_content 'スタンプラリー参加者'
      expect(page).to have_link trainee1.name

      click_link trainee1.name

      expect(current_path).to eq user_path(trainee1)
      expect(page).to have_selector '.stamps__user-name', text: trainee1.name
    end
  end

  context 'trainee としてログイン' do
    context 'スタンプラリー開始前' do
      scenario 'スタンプラリー開始ボタンが押せる' do
        signin_as trainee1

        expect(trainee1.rally_started?).to be_falsy
        expect(page).to have_link 'スタンプラリーを開始'
        expect(page).to_not have_selector '.stamps__user-name', text: trainee1.name

        click_link 'スタンプラリーを開始'

        expect(current_path).to eq root_path
        expect(page).to have_selector '.stamps__user-name', text: trainee1.name
      end
    end

    context 'スタンプラリー開始後' do
      before do
        trainee1.start_rally!
      end

      scenario '自分のスタンプが見える' do
        signin_as trainee1

        expect(trainee1.rally_started?).to be_truthy
        expect(page).to_not have_link 'スタンプラリーを開始'
        expect(page).to have_selector '.stamps__user-name', text: trainee1.name
        expect(page).to have_selector '.stamps__frame', count: User.master_count
      end
    end
  end
end