import { Router } from "express";
import AdminController from "../controllers/auth/AdminController";
import CandidateController from './../controllers/auth/CandidateController';
import CompanyController from './../controllers/auth/CompanyController';

const router = Router()

/**
 * @description 1. create a new user then login user
 * @param { email:String, name:String, password:String } = req.body
 * @endpoint http://localhost:2727/auth/signup
 * @example same
 */
router.post('/signup', AdminController.signUp)
router.post('/signup-candidate', CandidateController.signUpCandidate)
router.post('/signup-company', CompanyController.signUpCompany)

/**
 * @description 2. login user
 * @param { email:String, password:String } = req.body
 * @endpoint http://localhost:2727/auth/login
 * @example same
 */
router.post('/login', AdminController.login)
router.post('/login-candidate', CandidateController.loginCandidate)
router.post('/login-company', CompanyController.loginCompany)

/**
 * @description 3. logout user
 * @endpoint http://localhost:2727/auth/logout
 * @example same
 */
router.get('/logout', AdminController.logout)

/**
 * @description 4. ck logged in or not
 * @endpoint http://localhost:2727/auth/is-loggedin
 * @example same
 */
router.get('/is-loggedin', AdminController.isLoggedIn)

/**
 * @description 5. forget password
 * @endpoint http://localhost:2727/auth/forget-password
 * @example same
 */
router.post('/forget-password', (req, res) => {
    res.json({ ok: "OK" })
})

/**
 * @description 6. change password
 * @endpoint http://localhost:2727/auth/change-password
 * @example same
 */


export default router