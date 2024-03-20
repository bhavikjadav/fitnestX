import UIKit

class OnBoardingStepsViewController: UIViewController {

    @IBOutlet weak var OnBoardNextBtn: UIButton!
    @IBOutlet weak var nextBoardImage: UIImageView!
    @IBOutlet weak var nextBoardTitle: UILabel!
    @IBOutlet weak var nextBoardDescription: UILabel!
    
    private var progressLayer = CAShapeLayer()
        private var currentStep = 0 { // Start from the second step
            didSet {
                setProgress(CGFloat(currentStep + 1) / CGFloat(imageArr.count))
                nextBoardImage.image = imageArr[currentStep]
                nextBoardTitle.text = titleArr[currentStep]
                nextBoardDescription.text = descArr[currentStep]
            }
        }
    
    private let progressLayerMargin: CGFloat = 7.0
    
    let imageArr = [UIImage(named: "TrackYourGoal"), UIImage(named: "GetBurn"), UIImage(named: "EatWell"), UIImage(named: "ImproveSleep")].compactMap { $0 }
    let titleArr = ["Track Your Goal", "Get Burn", "Eat Well", "Improve Sleep  Quality"]
    let descArr = [
        "Don't worry if you have trouble determining your goals, We can help you determine your goals and track your goals",
        "Let’s keep burning, to achive yours goals, it hurts only temporarily, if you give up now you will be in pain forever",
        "Let's start a healthy lifestyle with us, we can determine your diet every day. healthy eating is fun",
        "Improve the quality of your sleep with us, good quality sleep can bring a good mood in the morning"]

    override func viewDidLoad() {
        super.viewDidLoad()

        let buttonImage = UIImage(named: "ArrowRight")
        OnBoardNextBtn.setImage(buttonImage, for: .normal)
        buttonStyle()
        setupProgressLayer()
        OnBoardNextBtn.addTarget(self, action: #selector(handleNextButtonTap), for: .touchUpInside)
        if !imageArr.isEmpty {
            nextBoardImage.image = imageArr[currentStep]
        }
        setProgress(CGFloat(currentStep + 1) / CGFloat(imageArr.count))  // Initialize progress to 1
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyGradientToButton()
        updateProgressLayerFrame()
    }

    @objc private func handleNextButtonTap() {
        if currentStep < imageArr.count - 1 {
            currentStep += 1
        }
    }

    func buttonStyle() {
        OnBoardNextBtn.setTitleColor(.blue, for: .normal)
        OnBoardNextBtn.titleLabel?.font = UIFont(name: "Poppins-Bold", size: 20.0)
        OnBoardNextBtn.layer.cornerRadius = OnBoardNextBtn.frame.height / 2
    }

    private func applyGradientToButton() {
        OnBoardNextBtn.layer.sublayers?.filter { $0 is CAGradientLayer }.forEach { $0.removeFromSuperlayer() }

        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = OnBoardNextBtn.bounds

        let color1 = UIColor(hex: "#9DCEFF") ?? .blue
        let color2 = UIColor(hex: "#92A3FD") ?? .blue

        gradientLayer.colors = [color1.cgColor, color2.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.cornerRadius = OnBoardNextBtn.layer.cornerRadius

        OnBoardNextBtn.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupProgressLayer() {
        progressLayer.strokeColor = UIColor.blue.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 2
        progressLayer.strokeEnd = 0
        OnBoardNextBtn.layer.addSublayer(progressLayer)
    }

    private func updateProgressLayerFrame() {
        progressLayer.frame = OnBoardNextBtn.bounds
        let center = CGPoint(x: OnBoardNextBtn.bounds.midX, y: OnBoardNextBtn.bounds.midY)
        let radius = min(OnBoardNextBtn.bounds.width, OnBoardNextBtn.bounds.height) / 2 + progressLayer.lineWidth / 2 + progressLayerMargin
        let path = UIBezierPath(arcCenter: center, radius: radius - progressLayer.lineWidth / 2, startAngle: -(.pi / 2), endAngle: 2 * .pi - (.pi / 2), clockwise: true)
        progressLayer.path = path.cgPath
    }

    private func setProgress(_ progress: CGFloat) {
        progressLayer.strokeEnd = progress
    }
}
