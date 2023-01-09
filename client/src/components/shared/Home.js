import { useContext } from "react"
import Badge from "react-bootstrap/esm/Badge"
import { Link } from "react-router-dom"
import { AuthContext } from "../../providers/AuthProvider"
import Card from "../Card"
import ContentCard from "./ContentCard"

const Home = ()=>{
    
    // let auth = useContext(AuthContext)
    // if(!auth.user){
    //     return <p>
    //         Welcome to the starter app!
    //     </p>
    // }

    return (
        <Card>
        <div>
            <p>Feed/Home page</p>
            <ContentCard>
            <p>Content</p>
            </ContentCard>
            <ContentCard>
            <p>Content</p>
            </ContentCard> <ContentCard>
            <p>Content</p>
            </ContentCard>
        </div>
        </Card>
    )
} 
export default Home