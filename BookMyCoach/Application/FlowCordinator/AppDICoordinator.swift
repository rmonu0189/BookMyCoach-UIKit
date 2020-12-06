//
//  AppDICoordinator.swift
//  BookMyCoach
//
//  Created by Monu Rathor on 05/12/20.
//

import UIKit

class AppDICoordinator {
    
    // MARK: - View Controller
    class func appNavigation(_ controller: UIViewController, isLargeTitle: Bool = false) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: controller)
        navigation.navigationBar.prefersLargeTitles = isLargeTitle
        navigation.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigation.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigation.navigationBar.tintColor = .white
        navigation.navigationBar.barTintColor = UIColor.themeBackground
        return navigation
    }
    
    class func setRootControllerForLoggedInUser() {
        let user = UserManager.shared.activeUser
        let controller = appTabBarController(user?.userType ?? .player)
        AppDelegate.shared.window?.rootViewController = controller
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
    class func setRootControllerAfterLoggedOutUser() {
        let controller = appNavigation(loginViewController(), isLargeTitle: true)
        AppDelegate.shared.window?.rootViewController = controller
        AppDelegate.shared.window?.makeKeyAndVisible()
    }
    
    class func rootController() -> UIViewController {
        if UserManager.shared.isLoggedInUser() == true {
            let user = UserManager.shared.activeUser
            if user?.isProfileComplete == false {
                return appNavigation(updateProfileViewController(), isLargeTitle: true)
            } else {
                return appTabBarController(user?.userType ?? .player)
            }
        } else {
            return appNavigation(loginViewController(), isLargeTitle: true)
        }
    }
    
    class func appTabBarController(_ userType: UserType) -> UITabBarController {
        return AppTabBarViewController.create(userType)
    }
    
    class func loginViewController() -> LoginViewController {
        let controller = UIViewController.controller(LoginViewController.self, name: .Authentication)
        let useCase = LoginUseCase(repository: UserRepository())
        controller.loginViewModel = LoginViewModel(userCase: useCase)
        return controller
    }
    
    class func newAccountViewController() -> NewAccountViewController {
        let controller = UIViewController.controller(NewAccountViewController.self, name: .Authentication)
        let useCase = RegisterUseCase(repository: UserRepository())
        controller.viewModel = NewAccountViewModel(userCase: useCase)
        return controller
    }
    
    class func updateProfileViewController(viewMode: ViewMode = .normal) -> UpdateProfileViewController {
        let controller = UIViewController.controller(UpdateProfileViewController.self, name: .Authentication)
        let updateUserUseCase = UpdateUserUseCase(repository: UserRepository())
        let uploadImageUserCase = UploadProfilePhotoUseCase(repository: UploadImageRepository())
        let user = UserManager.shared.activeUser
        controller.viewModel = UpdateProfileViewModel(user: user, updateUserUseCase: updateUserUseCase, uploadImageUserCase: uploadImageUserCase, viewMode: viewMode)
        return controller
    }
    
    class func sportListViewController(viewMode: ViewMode = .normal) -> SportListViewController {
        let controller = UIViewController.controller(SportListViewController.self, name: .Authentication)
        let sportListUseCase = SportListUseCase(repository: SportRepository())
        let updateSportUserCase = UpdateSportUseCase(repository: SportRepository())
        let selectedSport = UserManager.shared.activeUser?.userSports?.first?.sport
        controller.viewModel = SportListViewModel(selectedSport: selectedSport, sportListUseCase: sportListUseCase, updateSportUserCase: updateSportUserCase, viewMode: viewMode)
        return controller
    }
    
    class func homeViewController(_ type: UserType?) -> UIViewController {
        if type == UserType.player {
            return playerHomeViewController()
        } else {
            return coachHomeViewController()
        }
    }
    
    class func playerHomeViewController() -> UIViewController {
        let controller = UIViewController.controller(PlayerHomeViewController.self, name: .Home)
        let myBookingUseCase = MyBookingUseCase(repository: BookingRepository())
        let nearbyCoachUseCase = NearbyCoachUseCase(repository: CoachRepository())
        let sportListUseCase = SportListUseCase(repository: SportRepository())
        let bookCoachUseCase = BookCoachUseCase(repository: CoachRepository())
        let viewModel = PlayerHomeViewModel(myBookingUseCase: myBookingUseCase, nearbyCoachUseCase: nearbyCoachUseCase, sportListUseCase: sportListUseCase, bookCoachUseCase: bookCoachUseCase, locationManager: LocationManager())
        controller.viewModel = viewModel
        return controller
    }
    
    class func coachHomeViewController() -> UIViewController {
        let controller = UIViewController.controller(CoachHomeViewController.self, name: .Home)
        let myBookingUseCase = MyBookingUseCase(repository: BookingRepository())
        let pendingBookingUseCase = CoachPendingInvitationUseCase(repository: BookingRepository())
        let bookingResponseUseCase = CoachResponseUseCase(repository: BookingRepository())
        let viewModel = CoachHomeViewModel(pendingInvitationUseCase: pendingBookingUseCase, myBookingUseCase: myBookingUseCase, responseToBookingUseCase: bookingResponseUseCase, locationManager: LocationManager())
        controller.viewModel = viewModel
        return controller
    }
    
    class func chatViewController() -> UIViewController {
        return UIViewController.controller(ChatViewController.self, name: .Chat)
    }
    
    class func memberViewController() -> UIViewController {
        return UIViewController.controller(MemberViewController.self, name: .Member)
    }
    
    class func profileViewController() -> ProfileViewController {
        let user = UserManager.shared.activeUser
        let controller = UIViewController.controller(ProfileViewController.self, name: .Profile)
        let useCase = LogoutUserUseCase(repository: UserRepository())
        controller.viewModel = ProfileViewModel(user: user, logoutUserUseCase: useCase)
        return controller
    }
    
    class func changePasswordViewController() -> UIViewController {
        let controller = UIViewController.controller(ChangePasswordViewController.self, name: .Profile)
        let useCase = ChangePasswordUseCase(repository: UserRepository())
        controller.viewModel = ChangePasswordViewModel(changePasswordUseCase: useCase)
        return controller
    }
    
}
