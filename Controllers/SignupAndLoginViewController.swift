import UIKit
import GoogleSignIn
import FBSDKLoginKit
import FirebaseAuth

class SignupAndLoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: - Outlets
    @IBOutlet weak var firstNameField: FXCustomTextField!
    @IBOutlet weak var lastNameField: FXCustomTextField!
    @IBOutlet weak var emailField: FXCustomTextField!
    @IBOutlet weak var passwordField: FXCustomTextField!
    @IBOutlet weak var registerBtn: FXPrimaryButton!
    @IBOutlet weak var registerWithGoogleBtn: FXSquareButtonWithIcon!
    @IBOutlet weak var registerWithFbBtn: FXSquareButtonWithIcon!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        setupObservers()
        loadBasicDesigns()
    }

    // MARK: - Setup
    private func setupObservers() {
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { _ in
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
    }

    private func loadBasicDesigns() {
        firstNameField.setLeftImage(UIImage(named: "profile.png")!)
        lastNameField.setLeftImage(UIImage(named: "profile.png")!)
        emailField.setLeftImage(UIImage(named: "message.png")!)
        passwordField.setLeftImage(UIImage(named: "lock.png")!)
        registerWithGoogleBtn.setIcon("google.png")
        registerWithFbBtn.setIcon("facebook.png")
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Textfield Delegate Methods
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.firstNameField.layer.borderColor = FX.colors.textFieldBorderColor
        self.emailField.layer.borderColor = FX.colors.textFieldBorderColor
        self.passwordField.layer.borderColor = FX.colors.textFieldBorderColor
    }

    // MARK: - Actions
    @IBAction func regWithGoogleTapped(_ sender: FXSquareButtonWithIcon) {
        handleGoogleSignInButton()
    }

    @IBAction func regWithFBTapped(_ sender: FXSquareButtonWithIcon) {
        facebookLogin()
    }
    
    @IBAction func regWithEmailAndPassword(_ sender: FXPrimaryButton) {
        if let email = emailField.text, let password = passwordField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    
                    if self.firstNameField.text == "" {
                        self.showAlert(title: "Your Good Name is Missing!", message: "Kindly Provide your First & Last Name")
                        self.firstNameField.layer.borderColor = FX.colors.dangerColor
                    } else if !email.validateEmailId() {
                        self.showAlert(title: "Invalid Email Address", message: "Kindly provide proper/valid email address.")
                        self.emailField.layer.borderColor = FX.colors.dangerColor
                    } else if e.localizedDescription == "The email address is already in use by another account." {
                        self.showAlert(title: "Email is already in use!", message: "Kindly enter new email address.")
                        self.emailField.layer.borderColor = FX.colors.dangerColor
                    } else if e.localizedDescription == "The password must be 6 characters long or more." {
                        self.showAlert(title: "Poor Password!", message: "The password must be 6 characters long or more.")
                        self.passwordField.layer.borderColor = FX.colors.dangerColor
                    }
                    print(e.localizedDescription)
                } else {
                    // Navigate to Next Screen
                    self.performSegue(withIdentifier: FX.segues.toCompleteProfile, sender: self)
                    print("User has been Registered.")
                }
            }
        }
    }
}

// MARK: - Google SignIn
extension SignupAndLoginViewController {
    func handleGoogleSignInButton() {
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            if let error = error {
                print("Google Sign-In error: \(error.localizedDescription)")
                return
            }
            // Navigate to Next Screen.
            self.performSegue(withIdentifier: FX.segues.toCompleteProfile, sender: self)
            print("Google Sign-In successful.")
        }
    }
}

// MARK: - Facebook Login
extension SignupAndLoginViewController {
    func facebookLogin() {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: ["public_profile"], from: self) { result, error in
            if let error = error {
                print("Facebook Login error: \(error.localizedDescription)")
            } else if let result = result, !result.isCancelled {
                self.fetchFacebookUserData()
                //Navigate to Next Screen
                self.performSegue(withIdentifier: FX.segues.toCompleteProfile, sender: self)
            } else {
                print("Facebook Login was cancelled.")
            }
        }
    }

    func fetchFacebookUserData() {
        guard AccessToken.current != nil else {
            print("No active Facebook access token.")
            return
        }

        GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"]).start { _, result, error in
            if let error = error {
                print("Facebook GraphRequest error: \(error.localizedDescription)")
                return
            }

            if let userData = result as? [String: Any], let userID = userData["id"] as? String, let name = userData["name"] as? String {
                print("User ID: \(userID)")
                print("Name: \(name)")
            }
        }
    }
}
