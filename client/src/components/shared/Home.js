import { useContext } from "react"
import Badge from "react-bootstrap/esm/Badge"
import { Link } from "react-router-dom"
import { AuthContext } from "../../providers/AuthProvider"
import Card from "../Card"
import ContentCard from "./ContentCard"
import Posts from "./Posts"

const Home = ()=>{
    
    return (
        <Card>
        <Posts/>
        </Card>
    )
} 
export default Home