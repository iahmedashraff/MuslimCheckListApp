//
//  HomeVC.swift
//  Muslim App
//
//  Created by Ahmed Ashraf on 27/10/2021.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore


class HomeVC: UIViewController {
    //MARK: -Constance
    var prayImage = [UIImage(named: "Fagr"),UIImage(named: "duha"),UIImage(named: "duhur"),UIImage(named: "asr"),UIImage(named: "maghreb"),UIImage(named: "isha")]
    var prayNames = ["الفجر","الضحى","الظهر","العصر","المغرب","العشاء"]
    var screenName = "Home"
    var userDateInApp = NSDate()
    
    let date = Date()
    var pray: [DailyReportModel] = []



    //MARK: -Outlets
    
    @IBOutlet weak var progressBarView: ProgressNIB!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblClock: UILabel!
    
    @IBOutlet weak var sleepZekrView: UIView!{
        didSet{
            sleepZekrView.layer.cornerRadius = 15

            sleepZekrView.layer.shadowOffset = CGSize(width: 1, height: 1)
            sleepZekrView.layer.shadowOpacity = 0.2
            sleepZekrView.layer.shadowRadius = 2.0
        }
    }
    @IBOutlet weak var nightZekrView: UIView!{
        didSet{
            nightZekrView.layer.cornerRadius = 15

            nightZekrView.layer.shadowOffset = CGSize(width: 1, height: 1)
            nightZekrView.layer.shadowOpacity = 0.2
            nightZekrView.layer.shadowRadius = 2.0
        }
    }
    @IBOutlet weak var morningZekrView: UIView!{
        didSet{
            morningZekrView.layer.cornerRadius = 15

            morningZekrView.layer.shadowOffset = CGSize(width: 1, height: 1)
            morningZekrView.layer.shadowOpacity = 0.2
            morningZekrView.layer.shadowRadius = 2.0
        }
    }
    @IBOutlet weak var quranView: UIView!{
        didSet{
            quranView.layer.cornerRadius = 15

            quranView.layer.shadowOffset = CGSize(width: 1, height: 1)
            quranView.layer.shadowOpacity = 0.2
            quranView.layer.shadowRadius = 2.0
        }
    }
    @IBOutlet weak var ablutionView: UIView!{
        didSet{
            ablutionView.layer.cornerRadius = 15

            ablutionView.layer.shadowOffset = CGSize(width: 1, height: 1)
            ablutionView.layer.shadowOpacity = 0.2
            ablutionView.layer.shadowRadius = 2.0
        }
    }
    @IBOutlet weak var eatingView: UIView!{
        didSet{
            eatingView.layer.cornerRadius = 15

            eatingView.layer.shadowOffset = CGSize(width: 1, height: 1)
            eatingView.layer.shadowOpacity = 0.2
            eatingView.layer.shadowRadius = 2.0
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //saveUserLog()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
        syncDataWithPregress()

    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
        morningTabes()
        nightTabes()
        sleepTabes()
        ablutionTabes()
        eatTabes()

    }


    //MARK: -IBActions
    

    
    //MARK: -Helper Functions
    func getDate() -> String {
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day], from: Date())
        let year = components.year
        let month = components.month
        let day = components.day
        let dateString = String(year!) + "-" + String(month!) + "-" + String(day!)
        return dateString
    }
    func syncDataWithPregress(){
        guard let userID = Auth.auth().currentUser?.uid else {return}
        
        
        let docRef = db.collection("App Users").document(userID).collection("Dates").document("\(getDate())")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data() as? [String: Any]
                self.progressBarView.lblNumberOne.text = "\(data!.keys.count)"
                self.progressBarView.progressBar.progress = Float(data!.keys.count) / Float(self.pray.count)
            }else {
                print("Document does not exist")
            }
        }
    }
    func setupData(){
        let fajrSuna = DailyReportModel()
        fajrSuna.prayName = "سنة صلاة الفجر"
        fajrSuna.isSelected = false
        pray.append(fajrSuna)
        
        let fajr = DailyReportModel()
        fajr.prayName = "صلاة الفجر"
        fajr.isSelected = false
        pray.append(fajr)
        
        let duha = DailyReportModel()
        duha.prayName = "صلاة الضحي"
        duha.isSelected = false
        pray.append(duha)
        
        let duhrSona = DailyReportModel()
        duhrSona.prayName = "سنة صلاة الظهر"
        duhrSona.isSelected = false
        pray.append(duhrSona)
        
        let duhr = DailyReportModel()
        duhr.prayName = "صلاة الظهر"
        duhr.isSelected = false
        pray.append(duhr)
        
        let asr = DailyReportModel()
        asr.prayName = "صلاة العصر"
        asr.isSelected = false
        pray.append(asr)
        
        let majreebSona = DailyReportModel()
        majreebSona.prayName = "سنة صلاة المغرب"
        majreebSona.isSelected = false
        pray.append(majreebSona)
        
        let majreeb = DailyReportModel()
        majreeb.prayName = "صلاة المغرب"
        majreeb.isSelected = false
        pray.append(majreeb)
        
        let ishaSona = DailyReportModel()
        ishaSona.prayName = "سنه صلاة العشاء"
        ishaSona.isSelected = false
        pray.append(ishaSona)
        
        let isha = DailyReportModel()
        isha.prayName = "صلاة العشاء"
        isha.isSelected = false
        pray.append(isha)
        
        let morningZekr = DailyReportModel()
        morningZekr.prayName = "أذكار الصباح"
        isha.isSelected = false
        pray.append(morningZekr)
        
        let nightZekr = DailyReportModel()
        nightZekr.prayName = "أذكار المساء"
        nightZekr.isSelected = false
        pray.append(nightZekr)
        
        let sleepZekr = DailyReportModel()
        sleepZekr.prayName = "أذكار النوم"
        sleepZekr.isSelected = false
        pray.append(sleepZekr)
        
        let eatZekr = DailyReportModel()
        eatZekr.prayName = "أذكار قبل الأكل"
        eatZekr.isSelected = false
        pray.append(eatZekr)
        
        let ablutionZekr = DailyReportModel()
        ablutionZekr.prayName = "أذكار الوضوء"
        ablutionZekr.isSelected = false
        pray.append(ablutionZekr)
    }
    func setupUI(){
//        progressBarView.progresscolor = UIColor(hexString: "#ffffff")
//        progressBarView.backgroundProgresscolor = UIColor(hexString: "#ACB1B0")
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day], from: date)
        let year = components.year
        let month = components.month
        let day = components.day
        let dateString = String(year!) + "-" + String(month!) + "-" + String(day!)

        
       let formatter = DateFormatter()
        formatter.timeStyle = .short

        let dateTimeStrig = formatter.string(from: date)
        
        lblClock.text = dateTimeStrig
        lblDate.text = dateString
        
        //ProgressBar
        progressBarView.progressBar.trackTintColor = UIColor(hexString: "#ACB1B0")
        progressBarView.progressBar.progressTintColor = UIColor(hexString: "#ffffff")
        
    }
    func morningTabes(){
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(morningZekrTapped(tapGestureRecognizer:)))
        morningZekrView.isUserInteractionEnabled = true
        morningZekrView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func morningZekrTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view!
        let morningZekrVC = UIStoryboard(name: "Azkar", bundle: nil).instantiateViewController(withIdentifier: "MorningZekrVC") as! MorningZekrVC
        morningZekrVC.modalPresentationStyle = .fullScreen
        present(morningZekrVC, animated: true, completion: nil)
    }
    
    func nightTabes(){
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(nightZekrTapped(tapGestureRecognizer:)))
        nightZekrView.isUserInteractionEnabled = true
        nightZekrView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc func nightZekrTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view!
        let nightZekrVC = UIStoryboard(name: "Azkar", bundle: nil).instantiateViewController(withIdentifier: "NightZekrVC") as! NightZekrVC
        nightZekrVC.modalPresentationStyle = .fullScreen
        present(nightZekrVC, animated: true, completion: nil)
    }
    
    func sleepTabes(){
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(sleepZekrTapped(tapGestureRecognizer:)))
        sleepZekrView.isUserInteractionEnabled = true
        sleepZekrView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc func sleepZekrTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view!
        let sleepZekrVC = UIStoryboard(name: "Azkar", bundle: nil).instantiateViewController(withIdentifier: "SleepZekrVC") as! SleepZekrVC
        sleepZekrVC.modalPresentationStyle = .fullScreen
        present(sleepZekrVC, animated: true, completion: nil)
    }
    
    func ablutionTabes(){
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ablutionZekrTapped(tapGestureRecognizer:)))
        ablutionView.isUserInteractionEnabled = true
        ablutionView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc func ablutionZekrTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view!
        let ablutionZekrVC = UIStoryboard(name: "Azkar", bundle: nil).instantiateViewController(withIdentifier: "AblutionZekrVC") as! AblutionZekrVC
        ablutionZekrVC.modalPresentationStyle = .fullScreen
        present(ablutionZekrVC, animated: true, completion: nil)
    }
    
    func eatTabes(){
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(eatZekrTapped(tapGestureRecognizer:)))
        eatingView.isUserInteractionEnabled = true
        eatingView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    @objc func eatZekrTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view!
        let eatZekrVC = UIStoryboard(name: "Azkar", bundle: nil).instantiateViewController(withIdentifier: "EatZekrVC") as! EatZekrVC
        eatZekrVC.modalPresentationStyle = .fullScreen
        present(eatZekrVC, animated: true, completion: nil)
    }
    
   

    
}


    //MARK: - Extension
extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return prayImage.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! preyerCViewCell
        cell.prayImage.image = prayImage[indexPath.row]
        cell.prayNames.text = prayNames[indexPath.row]
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: collectionView.frame.size.height, height: collectionView.frame.size.height)
    }
  
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        switch indexPath.row{
        case 0:
            let fajr = UIStoryboard(name: "Prays", bundle: nil).instantiateViewController(withIdentifier: "FajrPrayVC") as! FajrPrayVC
            
            fajr.modalPresentationStyle = .fullScreen
            present(fajr, animated: true, completion: nil)
        case 1:
            let duha = UIStoryboard(name: "Prays", bundle: nil).instantiateViewController(withIdentifier: "DuhaPrayVC") as! DuhaPrayVC
            
            duha.modalPresentationStyle = .fullScreen
            present(duha, animated: true, completion: nil)
        case 2:
            let duhr = UIStoryboard(name: "Prays", bundle: nil).instantiateViewController(withIdentifier: "DuhrPrayVC") as! DuhrPrayVC
            
            duhr.modalPresentationStyle = .fullScreen
            present(duhr, animated: true, completion: nil)
        case 3:
            let asr = UIStoryboard(name: "Prays", bundle: nil).instantiateViewController(withIdentifier: "AsrPrayVC") as! AsrPrayVC
            
            asr.modalPresentationStyle = .fullScreen
            present(asr, animated: true, completion: nil)
        case 4:
            let maghreb = UIStoryboard(name: "Prays", bundle: nil).instantiateViewController(withIdentifier: "MaghrebPrayVC") as! MaghrebPrayVC
            
            maghreb.modalPresentationStyle = .fullScreen
            present(maghreb, animated: true, completion: nil)
        case 5:
            let isha = UIStoryboard(name: "Prays", bundle: nil).instantiateViewController(withIdentifier: "IshaPrayVC") as! IshaPrayVC
            
            isha.modalPresentationStyle = .fullScreen
            present(isha, animated: true, completion: nil)
        default:
            print("error")

        }
        
    }

}

extension Date {
    init(_ dateString:String) {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX") as Locale
        let date = dateStringFormatter.date(from: dateString)!
        self.init(timeInterval:0, since:date)
    }
}
